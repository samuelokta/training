@isTest
private class WarehouseCalloutServiceTest {
  // implement your mock callout test here
  @isTest static void successRequest() 
    {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 

        Test.startTest();

            WarehouseCalloutService.runWarehouseEquipmentSync();

        Test.stopTest();

        List<Product2> equipments = [SELECT Name, 
                                            Replacement_Part__c, 
                                            Maintenance_Cycle__c, 
                                            Lifespan_Months__c,
                                            Warehouse_SKU__c,
                                            Cost__c
                                    FROM    Product2];

        System.assertEquals(WarehouseCalloutServiceMock.RESPONSE_BODY_MAINTENANCEPERIOD, equipments.get(0).Maintenance_Cycle__c);
        System.assertEquals(WarehouseCalloutServiceMock.RESPONSE_BODY_LIFESPAN_SKU, equipments.get(0).Warehouse_SKU__c);
        System.assertEquals(WarehouseCalloutServiceMock.RESPONSE_BODY_NAME, equipments.get(0).Name);
        System.assertEquals(WarehouseCalloutServiceMock.RESPONSE_BODY_COST, equipments.get(0).Cost__c);
        System.assertEquals(WarehouseCalloutServiceMock.RESPONSE_BODY_REPLACEMENT, equipments.get(0).Replacement_Part__c);

    }
}