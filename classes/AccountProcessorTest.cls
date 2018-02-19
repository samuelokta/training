@isTest
private class AccountProcessorTest {

    @isTest static void AccountProcessorTest() {


        Account acc = new Account();
        acc.Name = 'test account';
        insert acc;

        Contact c = new Contact();
        c.AccountId = acc.Id;
        c.FirstName = 'FirstName';
        c.LastName = 'LastName';
        insert c;

        Test.startTest();

            AccountProcessor.countContacts(new List<String>{acc.Id});

        Test.stopTest();
        
        Account verifyAcc = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id = :acc.Id];

        system.assert(verifyAcc.Number_of_Contacts__c == 1);
    }
}
