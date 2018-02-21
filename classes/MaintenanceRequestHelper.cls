public with sharing class MaintenanceRequestHelper 
{
    private static final Set<String> MAINTENANCE_TYPE = new Set<String>{'Repair','Routine Maintenance'};
    public static final String CASE_STATUS_CLOSED = 'Closed';
    public static final String CASE_STAUS_NEW = 'New';
    public static final String CASE_TYPE_REPAIR = 'Repair';
    public static final String CASE_TYPE_ROUTINE_MAINTENANCE = 'Routine Maintenance';

    public static void automateMaintenanceRequests()
    {
        if(Trigger.isAfter && Trigger.isUpdate)
        {   
            Map<String, Case> casesToAutomateCreation = new Map<String, Case>();
            Map<String, Date> initialDueDateByCaseId = new Map<String, Date>();
            List<Work_Part__c> workPlansToInsert = new List<Work_Part__c>();
            Map<String,Decimal> minDueDateByCaseId = new Map<String,Decimal>();
            Map<String,List<Work_Part__c>> caseIdToWorkPlans = new Map<String,List<Work_Part__c>>();

            for(SObject so :Trigger.new)
            {
                Case newCase = (Case)so;
                Case oldCase = (Case)so;
                
                if(MAINTENANCE_TYPE.contains(newCase.Type) && newCase.Status == CASE_STATUS_CLOSED)
                {   
                    Case clone = newCase.clone();
                    clone.Status = CASE_STAUS_NEW;
                    clone.Type = CASE_TYPE_ROUTINE_MAINTENANCE;
                    clone.Date_Reported__c = Date.today();
                    casesToAutomateCreation.put(newCase.Id, clone);
                    initialDueDateByCaseId.put(newCase.Id, (clone.Date_Due__c!=null)?clone.Date_Due__c:Date.today());
                }
            }
            
            if(casesToAutomateCreation.size()>0)
            {
                List<Work_Part__c> workParts = [SELECT  Id, 
                                                        Name,
                                                        Maintenance_Request__c, 
                                                        Equipment__c, 
                                                        Quantity__c, 
                                                        Equipment__r.Maintenance_Cycle__c 
                                                FROM    Work_Part__c 
                                                WHERE   Maintenance_Request__c IN :casesToAutomateCreation.keySet()];

                for(Work_Part__c workPart :workParts)
                {   
                    String caseId = workPart.Maintenance_Request__c;

                    if( minDueDateByCaseId.get(caseId) == null || minDueDateByCaseId.get(caseId) > workPart.Equipment__r.Maintenance_Cycle__c)
                    {	
                        
                        minDueDateByCaseId.put(caseId, workPart.Equipment__r.Maintenance_Cycle__c);
                        casesToAutomateCreation.get(caseId).Date_Due__c = initialDueDateByCaseId.get(caseId).addDays(workPart.Equipment__r.Maintenance_Cycle__c.intValue());
                    }
                    if(caseIdToWorkPlans.get(caseId) == null)
                    {
                        caseIdToWorkPlans.put(caseId, new List<Work_Part__c>());
                    }
                    caseIdToWorkPlans.get(caseId).add(workPart);
                }
                
                insert casesToAutomateCreation.values();
                
                for(String caseId :caseIdToWorkPlans.keySet())
                {
                    workPlansToInsert.addAll(cloneWorkParts(casesToAutomateCreation.get(caseId).Id, caseIdToWorkPlans.get(caseId)));
                }
                
                insert workPlansToInsert;
            }
        }
    }

    private static List<Work_Part__c> cloneWorkParts(String caseId, List<Work_Part__c> workParts)
    {
        List<Work_Part__c> toReturn  = new List<Work_Part__c>();
        for(Work_Part__c workPart :workParts)
        {
            Work_Part__c aux = workPart.clone();
            aux.Maintenance_Request__c = caseId;
            toReturn.add(aux);
        }
        return toReturn;
    }
}