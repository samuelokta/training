trigger AccountAddressTrigger on Account (before insert, before update) 
{

    for(SObject so :Trigger.new)
    {
        Account a = (Account)so;
        if(!String.isEmpty(a.BillingPostalCode) && a.Match_Billing_Address__c)
        {
            a.ShippingPostalCode=a.BillingPostalCode;
        }

    }

}