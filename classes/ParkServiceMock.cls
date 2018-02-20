@isTest
global class ParkServiceMock implements WebServiceMock{
    
    global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
        ParkService.byCountryResponse response_x = 
            new calculatorServices.byCountryResponse();
        ParkService.return_x = new List<String>{'resp_1','resp_2','resp_3'};
        // end
        response.put('response_x', response_x); 
   }
}