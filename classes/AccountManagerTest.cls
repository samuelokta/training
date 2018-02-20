@isTest
public with sharing class AccountManagerTest {
    
    @isTest static void getAccountAndContacts() {

        Account acc = new Account();
        acc.Name = 'test Acc';

        insert acc;

        Contact c = new Contact();
        c.FirstName = 'FirstName';
        c.LastName = 'LastName';
        c.AccountId = acc.Id;

        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+acc.Id+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account accountResp = AccountManager.getAccount();
        // Verify results
        System.assert(accountResp != null);
    }

    @isTest static void accountNotExist() {

        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/123/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account accountResp = AccountManager.getAccount();
        // Verify results
        System.assert(accountResp == null);
    }
}