@isTest
private with sharing class AnimalLocatorTest 
{
    

    @isTest static void successRequest() 
    {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 

        Test.startTest();

            String animalName = AnimalLocator.getAnimalNameById(1);
            system.assertEquals('Pluto', animalName);

        Test.stopTest();
    }

    @isTest static void errorRequest() 
    {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorFailMock()); 

        Test.startTest();

            String animalName = AnimalLocator.getAnimalNameById(1);
            system.assertEquals('', animalName);

        Test.stopTest();
    }
}
