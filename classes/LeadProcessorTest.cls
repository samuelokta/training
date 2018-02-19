@isTest
private class LeadProcessorTest 
{
    
    
    @isTest static void LeadProcessorTest() 
    {   
        List<Lead> leads = new List<Lead>();

        for (Integer i=0; i<200; i++) {
            leads.add(new Lead(LastName='Lead '+i, Company='com'));
        }

        insert leads;

        Test.startTest();

            LeadProcessor lp = new LeadProcessor();
            Id batchId = Database.executeBatch(lp);

        Test.stopTest();

        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}
