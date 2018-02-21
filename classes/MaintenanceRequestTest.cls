@isTest
public with sharing class MaintenanceRequestTest {
    
    @isTest static void updateMaintenanceRequestTypeRepairToClose() {

        List<Vehicle__c> vehicles = TestFactory.createVehicle(1);
        insert vehicles;

        List<Product2> products = TestFactory.createEquipment(1, true, 5, 200, '0000003');
        insert products;

        List<Case> cases = TestFactory.createMaintenanceRequest(1, MaintenanceRequestHelper.CASE_STAUS_NEW,
            MaintenanceRequestHelper.CASE_TYPE_REPAIR,
            vehicles.get(0).Id,
            null
        );
        insert cases;
        
        List<Work_Part__c> workParts = TestFactory.createWorkPart( 1, products.get(0).Id, cases.get(0).id);
        insert workParts;

        Test.startTest();

            cases.get(0).Status = MaintenanceRequestHelper.CASE_STATUS_CLOSED;
            update cases;

            List<Case> case_aux = [ SELECT  Id, 
                                            Date_Due__c,
                                            Vehicle__c, 
                                            Type,
                                            Date_Reported__c,
                                            (SELECT Id,
                                                    Equipment__c
                                            FROM Work_Parts__r ) 
                                    FROM Case 
                                    WHERE id != :cases.get(0).id];

            System.assertEquals(1, case_aux.get(0).Work_Parts__r.size());
            System.assertEquals(vehicles.get(0).Id, case_aux.get(0).Vehicle__c);
            System.assertEquals(Date.today().addDays(5).format(), case_aux.get(0).Date_Due__c.format());
            System.assertEquals(products.get(0).Id, case_aux.get(0).Work_Parts__r.get(0).Equipment__c);
            System.assertEquals(MaintenanceRequestHelper.CASE_TYPE_ROUTINE_MAINTENANCE, case_aux.get(0).Type);
            System.assertEquals(Date.today(), case_aux.get(0).Date_Reported__c);

        Test.stopTest();
    }
    
    @isTest static void updateMaintenanceRequestTypeRoutineMaintenanceToClose() {

        List<Vehicle__c> vehicles = TestFactory.createVehicle(1);
        insert vehicles;

        List<Product2> products = TestFactory.createEquipment(1, true, 5, 200, '0000003');
        insert products;

        List<Case> cases = TestFactory.createMaintenanceRequest(1, MaintenanceRequestHelper.CASE_STAUS_NEW,
            MaintenanceRequestHelper.CASE_TYPE_ROUTINE_MAINTENANCE,
            vehicles.get(0).Id,
            null
        );
        insert cases;
        
        List<Work_Part__c> workParts = TestFactory.createWorkPart( 1, products.get(0).Id, cases.get(0).id);
        insert workParts;

        Test.startTest();

            cases.get(0).Status = MaintenanceRequestHelper.CASE_STATUS_CLOSED;
            update cases;

            List<Case> case_aux = [ SELECT  Id, 
                                            Date_Due__c,
                                            Vehicle__c, 
                                            Type,
                                            Date_Reported__c,
                                            (SELECT Id,
                                                    Equipment__c
                                            FROM Work_Parts__r ) 
                                    FROM Case 
                                    WHERE id != :cases.get(0).id];

            System.assertEquals(1, case_aux.get(0).Work_Parts__r.size());
            System.assertEquals(vehicles.get(0).Id, case_aux.get(0).Vehicle__c);
            System.assertEquals(Date.today().addDays(5).format(), case_aux.get(0).Date_Due__c.format());
            System.assertEquals(products.get(0).Id, case_aux.get(0).Work_Parts__r.get(0).Equipment__c);
            System.assertEquals(MaintenanceRequestHelper.CASE_TYPE_ROUTINE_MAINTENANCE, case_aux.get(0).Type);
            System.assertEquals(Date.today(), case_aux.get(0).Date_Reported__c);

        Test.stopTest();
    }

    @isTest static void updateMaintenanceRequestTypeRepairToCloseBulk() {

        Integer MAX_VEHICLES = 300;

        List<Vehicle__c> vehicles = TestFactory.createVehicle(MAX_VEHICLES);
        insert vehicles;

        List<Product2> products = TestFactory.createEquipment(1, true, 5, 200, '0000003');
        insert products;

        List<Case> cases = TestFactory.createMaintenanceRequestBulk(vehicles, MaintenanceRequestHelper.CASE_STAUS_NEW,
            MaintenanceRequestHelper.CASE_TYPE_REPAIR,
            Date.today()
        );
        insert cases;
        
        List<Work_Part__c> workParts = TestFactory.createWorkPartBulk( cases, products.get(0).Id);
        insert workParts;

        Test.startTest();

            Map<Id,Case> casesMap = new Map<Id,Case>();

            for(Case c :cases)
            {
                c.Status = MaintenanceRequestHelper.CASE_STATUS_CLOSED;
                casesMap.put(c.Id, c);
            }
            
            update cases;

            List<Case> cases_aux = [ SELECT  Id, 
                                            Date_Due__c,
                                            Vehicle__c, 
                                            Type,
                                            Date_Reported__c,
                                            (SELECT Id,
                                                    Equipment__c
                                            FROM Work_Parts__r ) 
                                    FROM Case 
                                    WHERE id IN :casesMap.keySet()];

            System.assertEquals(MAX_VEHICLES, cases_aux.size());

        Test.stopTest();
    }

    @isTest static void testShortestMaintenanceCycle() 
    {
        List<Vehicle__c> vehicles = TestFactory.createVehicle(1);
        insert vehicles;

        List<Product2> products = TestFactory.createEquipment(1, true, 5, 200, '0000003');
        products.addAll(TestFactory.createEquipment(1, true, 3, 200, '0000003'));
        insert products;

        List<Case> cases = TestFactory.createMaintenanceRequest(1, MaintenanceRequestHelper.CASE_STAUS_NEW,
            MaintenanceRequestHelper.CASE_TYPE_ROUTINE_MAINTENANCE,
            vehicles.get(0).Id,
            null
        );
        insert cases;
        
        List<Work_Part__c> workParts = TestFactory.createWorkPart( 1, products.get(0).Id, cases.get(0).id);
        workParts.addAll(TestFactory.createWorkPart( 1, products.get(1).Id, cases.get(0).id));
        insert workParts;

        Test.startTest();

            cases.get(0).Status = MaintenanceRequestHelper.CASE_STATUS_CLOSED;
            update cases;

            List<Case> case_aux = [ SELECT  Id, 
                                            Date_Due__c 
                                    FROM Case 
                                    WHERE id != :cases.get(0).id];

            System.assertEquals(Date.today().addDays(3).format(), case_aux.get(0).Date_Due__c.format());

        Test.stopTest();
    }
}
