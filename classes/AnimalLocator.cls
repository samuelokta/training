public with sharing class AnimalLocator {

    private static string path = 'https://th-apex-http-callout.herokuapp.com/animals/';

    public static String getAnimalNameById(integer num) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(path+num);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            
            Map<String, Object> animalWrapper = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animal = (Map<String, Object>)animalWrapper.get('animal');
            return (String)animal.get('name');
        }
        return '';
    }
}
