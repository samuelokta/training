@isTest
private class TestRestrictContactByName 
{

    @isTest public static void invalidLastName() 
    {
        Contact c  = new Contact();
        c.FirstName = 'FirstName';
        c.LastName = 'INVALIDNAME';

        test.startTest();
            try
            {
                insert c;
            }catch(Exception e)
            {
                system.assert(e.getMessage().contains('The Last Name'));
            }
        test.stopTest();
    }

    @isTest public static void validLastName() 
    {
        Contact c  = new Contact();
        c.FirstName = 'FirstName';
        c.LastName = 'LastName';
        test.startTest();
            insert c;
        test.stopTest();
    }
}
