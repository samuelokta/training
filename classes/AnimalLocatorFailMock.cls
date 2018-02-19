@isTest
global with sharing class AnimalLocatorFailMock implements HttpCalloutMock
{

    global HTTPResponse respond(HTTPRequest request) 
    {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(500);
        return response; 
    }
}
