public class AddPrimaryContact implements Queueable 
{   
    private Contact contact {get;set;}
    private String stateAbbr {get;set;}

    public AddPrimaryContact(Contact c, String stateAbbr) 
    {   this.contact = c;
        this.stateAbbr = stateAbbr;
    }

    public void execute(QueueableContext context) 
    {
        List<Contact> toInsert = new List<Contact>();
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :this.stateAbbr LIMIT 200];
        for(Account acc :accounts)
        {   
            Contact  contact_aux =  this.contact.clone();
            contact_aux.AccountId = acc.Id;
            toInsert.add(contact_aux);
        }
        insert toInsert;
    }
}
