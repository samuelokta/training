@isTest
private class AddPrimaryContactTest {
    
    
    @isTest static void AddPrimaryContactTest() {

        List<Account> accounts = new List<Account>();

        for(Integer index=0; index<50; index++)
        {
            accounts.add(new Account(Name='ny_'+index, BillingState='US'));
            accounts.add(new Account(Name='ca_'+index, BillingState='CA'));
        }

        insert accounts;

        Test.startTest();

            AddPrimaryContact apc = new AddPrimaryContact(new Contact(FirstName='ca_cont', LastName='ca_cont'),'CA');
            System.enqueueJob(apc);

        Test.stopTest();

        system.assertEquals(50, [select count() from Contact where Account.BillingState = 'CA']);

    }
}
