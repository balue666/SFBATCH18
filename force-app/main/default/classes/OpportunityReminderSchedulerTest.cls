@isTest
public with sharing class OpportunityReminderSchedulerTest {
    
    @TestSetup
    private static void makeData(){
        //we need to prepare some opps whose LastModifiedDate < THIS_WEEK
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i=1; i<=5; i++) {
            Opportunity opp = new Opportunity();
            opp.Name = 'Test Opp ' + i;
            opp.CloseDate = Date.today().addDays(i-3);
            opp.StageName = 'Prospecting';
            opps.add(opp);
        }
        insert opps;
    }

    @isTest
    private static void schedulerTest() {
        Test.startTest();
        OpportunityReminderScheduler m = new OpportunityReminderScheduler();
        String sch = '00 00 1 ? * 2';
        String jobID = System.schedule('Opprortunity Reminder', sch, m);
        Test.stopTest();
    }

    @isTest
    private static void batchTest() {
        Test.startTest();
        OpportunityReminderBatch batchable = new OpportunityReminderBatch();
        Database.executeBatch(batchable, 200);
        Test.stopTest();
        List<Task> tasks = [SELECT Id FROM Task];
        System.assertEquals(5, tasks.size());
    }
}
