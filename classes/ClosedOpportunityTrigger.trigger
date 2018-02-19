trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    private static string CLOSED_WON = 'Closed Won';
    private static string FOLLOW_UP_TEST_TASK = 'Follow Up Test Task';
    private List<Task> toInsert = new List<Task>();

    for(SObject so:Trigger.new)
    {   
        Opportunity opp = (Opportunity)so;

        if(opp.StageName == CLOSED_WON){

            if(Trigger.isInsert)
            {   
                Task t = new Task();
                t.WhatId = opp.Id;
                t.Subject = FOLLOW_UP_TEST_TASK;
                toInsert.add(t);
            }else
            {
                Opportunity oldOpp = (Opportunity)so;
                if(oldOpp.StageName!=opp.StageName)
                {   
                    Task t = new Task();
                    t.WhatId = opp.Id;
                    t.Subject = FOLLOW_UP_TEST_TASK;
                    toInsert.add(t);
                }
            }
        }
    }

    insert toInsert;
}
