@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @httpget
    global static Account getAccount() {
        
        RestRequest request = RestContext.request;
        String requestUrl = request.requestURI;
        String firstString = '/Accounts/';

        Integer firstIndex = requestUrl.lastIndexOf('/Accounts/');
        Integer lastIndex = requestUrl.indexOf('/contacts');

        String accountId = requestUrl.substring(firstIndex+firstString.length(), lastIndex);
        List<String> searchIn = new List<String>{accountId};
            
        List<Account> accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id IN :searchIn];

        if(accList.size()>0) return accList.get(0);

        return null;
    }
}