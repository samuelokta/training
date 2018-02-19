@isTest
private class TestVerifyDate 
{
    
    @isTest static void Date2LessThanDate1() 
    {

        Date one = date.newinstance(2018, 1, 1);

        Date two = date.newinstance(2017, 12, 20);

        Test.startTest();
            System.assertEquals('1/31/2018', VerifyDate.CheckDates(one,two).format());
        Test.stopTest();
    }

    @isTest static void Date2MoreThan30Days() 
    {

        Date one =  date.newinstance(2018, 1, 1);

        Date two =  date.newinstance(2018, 2, 1);

        Test.startTest();
            System.assertEquals('1/31/2018', VerifyDate.CheckDates(one,two).format());
        Test.stopTest();

    }

    @isTest static void Date2between30Days() 
    {

        Date one = Date.today();
        Date two = Date.today();

        two.addDays(1);
        
        Test.startTest();

            System.assertEquals(two.format(), VerifyDate.CheckDates(one,two).format());
        Test.stopTest();

    }
}
