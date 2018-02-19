
public with sharing class AccountProcessor 
{
    
    @future
    public static void countContacts(List<String> accountsId) 
    {

        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accountsId];
        List<Account> toUpdate = new List<Account>();

        for(Account acc :accounts)
        {
            if(acc.Contacts.size()>0)
            {
                toUpdate.add(new Account(Id=acc.Id, Number_of_Contacts__c=acc.Contacts.size() ));
            }
        }
        update toUpdate;
    }
}
