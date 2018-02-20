@isTest
private class ParkLocatorTest {

    @isTest static void successRespone() 
    {

        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        Test.startTest();
            List<String> lst = ParkLocator.country('Germany');
            system.assert(lst.size() > 0);
        Test.stopTest();
    }
}