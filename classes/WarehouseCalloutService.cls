public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true) 
    public static void runWarehouseEquipmentSync(){
        	
            List<Product2> toUpsert = new List<Product2>();

            Http http = new http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(WAREHOUSE_URL);
            req.setMethod('GET');

            HttpResponse resp = http.send(req);
            List<Object> inventoryObjList = (List<Object>)JSON.deserializeUntyped(resp.getBody());
             
            for(Object inventoryObj :inventoryObjList)
            {
                Map<String,Object> inventory = (Map<String,Object>)inventoryObj;
                
                Product2 prod = new Product2();
                prod.Cost__c = (Decimal)inventory.get('cost');
                prod.Replacement_Part__c = (Boolean)inventory.get('replacement');
                prod.Maintenance_Cycle__c = (Decimal)inventory.get('maintenanceperiod');
                prod.Lifespan_Months__c = (Decimal)inventory.get('lifespan');
                prod.Name = (String)inventory.get('name');
                prod.Warehouse_SKU__c = (String)inventory.get('sku');
                toUpsert.add(prod);
            }
            upsert toUpsert Warehouse_SKU__c;
    }
}