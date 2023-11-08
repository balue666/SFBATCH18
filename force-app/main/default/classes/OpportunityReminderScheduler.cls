public with sharing class OpportunityReminderScheduler implements Schedulable {
    
    public void execute(System.SchedulableContext sc) {
        OpportunityReminderBatch batchable = new OpportunityReminderBatch();
        Database.executeBatch(batchable, 200);
    }

}
