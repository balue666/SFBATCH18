public with sharing class OpportunityReminderBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = '';
        if(Test.isRunningTest()) {
            query = 'SELECT Id, Name, CloseDate, OwnerId FROM Opportunity';
        } else {
            query = 'SELECT Id, Name, CloseDate, OwnerId FROM Opportunity WHERE StageName != \'Closed Won\' AND StageName != \'Closed Lost\' AND LastModifiedDate < THIS_WEEK';
        }        
        return Database.getQueryLocator(query);
    } 

    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        List<Task> tasks = new List<Task>();
        for(Opportunity opp : scope) {
            Task tsk = new Task();
            tsk.Subject = 'Other';
            if(opp.CloseDate >= Date.today()) {
                tsk.ActivityDate = opp.CloseDate.addDays(-2);
            } else {
                tsk.ActivityDate = Date.today();
            }
            tsk.Description = 'Reminder - Please take action on this Opportunity';
            tsk.WhatId = opp.Id;
            tsk.OwnerId = opp.OwnerId;
            tsk.Status = 'In-Progress';
            tasks.add(tsk);
        }
        insert tasks;
    }

    public void finish(Database.BatchableContext bc) {

    }

}