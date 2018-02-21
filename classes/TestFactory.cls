public with sharing class TestFactory 
{


    public static List<Case> createMaintenanceRequest(Integer num, String status, String type, String vId, Date dueDate) 
    {
        List<Case> toReturn = new List<Case>();

        for(Integer index=0 ; index < num; index++)
        {
            Case rec = new Case();
            rec.Status = status;
            rec.Type = type;
            rec.Vehicle__c = vId;
            rec.Date_Due__c = dueDate;
            toReturn.add(rec);
        }
        return toReturn;
    }

    public static List<Case> createMaintenanceRequestBulk(List<Vehicle__c> vehicles, String status, String type, Date dueDate) 
    {
        List<Case> toReturn = new List<Case>();

        for(Integer index=0 ; index < vehicles.size(); index++)
        {
            Case rec = new Case();
            rec.Status = status;
            rec.Type = type;
            rec.Vehicle__c = vehicles.get(index).Id;
            rec.Date_Due__c = dueDate;
            toReturn.add(rec);
        }
        return toReturn;
    }

    public static List<Vehicle__c> createVehicle(Integer num) 
    {
        List<Vehicle__c> toReturn = new List<Vehicle__c>();

        for(Integer index=0 ; index < num; index++)
        {
            Vehicle__c rec = new Vehicle__c();
            rec.Name = 'n-'+index;
            toReturn.add(rec);
        }
        return toReturn;
    }

    public static List<Product2> createEquipment(  
                                    Integer num,
                                    Boolean replacement, 
                                    Integer maintenanceperiod,
                                    Integer cost,
                                    String  sku) 
    {
        List<Product2> toReturn = new List<Product2>();

        for(Integer index=0 ; index < num; index++)
        {
            Product2 rec = new Product2(); 
            rec.Cost__c = cost;
            rec.Replacement_Part__c = replacement;
            rec.Maintenance_Cycle__c = maintenanceperiod;
            rec.Name = 'n-'+index;
            rec.Warehouse_SKU__c = sku;
            toReturn.add(rec);
        }

        return toReturn;
    }

    public static List<Work_Part__c> createWorkPart(Integer num, String equipmentId, String caseId) 
    {  
        List<Work_Part__c> toReturn = new List<Work_Part__c>();

        for(Integer index=0 ; index < num; index++)
        {
            Work_Part__c rec = new Work_Part__c(); 
            rec.Equipment__c = equipmentId;
            rec.Maintenance_Request__c = caseId;
            rec.Quantity__c = 1;
            toReturn.add(rec);
        }
        return toReturn;
    }

    public static List<Work_Part__c> createWorkPartBulk(List<Case> cases, String equipmentId) 
    {
        List<Work_Part__c> toReturn = new List<Work_Part__c>();

        for(Integer index=0 ; index < cases.size(); index++)
        {
            Work_Part__c rec = new Work_Part__c(); 
            rec.Equipment__c = equipmentId;
            rec.Maintenance_Request__c = cases.get(index).Id;
            rec.Quantity__c = 1;
            toReturn.add(rec);
        }
        return toReturn;
    }
}
