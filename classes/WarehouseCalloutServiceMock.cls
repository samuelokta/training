@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock{
    // implement http mock callout
    
    public static final Boolean RESPONSE_BODY_REPLACEMENT = false;
    public static final Decimal RESPONSE_BODY_QUANTITY = 5;
    public static final String RESPONSE_BODY_NAME = 'Generator 1000 kW';
    public static final Decimal RESPONSE_BODY_MAINTENANCEPERIOD = 5000;
    public static final Decimal RESPONSE_BODY_LIFESPAN = 120;
    public static final Decimal RESPONSE_BODY_COST = 300;
    public static final String RESPONSE_BODY_LIFESPAN_SKU = '100003';

    private static final String RESPONSE_BODY = '[{"_id":"55d66226726b611100aaf741","replacement":'+RESPONSE_BODY_REPLACEMENT+',"quantity":'+RESPONSE_BODY_QUANTITY+',"name":"'+RESPONSE_BODY_NAME+'","maintenanceperiod":'+RESPONSE_BODY_MAINTENANCEPERIOD+',"lifespan":'+RESPONSE_BODY_LIFESPAN+',"cost":'+RESPONSE_BODY_COST+',"sku":"'+RESPONSE_BODY_LIFESPAN_SKU+'"}]';

    global HTTPResponse respond(HTTPRequest request) 
    {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(RESPONSE_BODY);
        response.setStatusCode(200);
        return response; 
    }
}