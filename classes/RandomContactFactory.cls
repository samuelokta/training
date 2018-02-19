public with sharing class RandomContactFactory 
{
    public RandomContactFactory() 
    {
    }

    public static List<Contact> generateRandomContacts(integer num, string lastname)
    {
        List<Contact> toReturn = new List<Contact>();
        for(integer index=0; index < num; index++)
        {
            toReturn.add(new Contact(FirstName='N-'+index, LastName=lastname));
        }
        return toReturn;
    }
}
