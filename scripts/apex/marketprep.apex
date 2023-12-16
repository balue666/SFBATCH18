Database.insert(List<sObject> collection, Boolean allOrNone);

    Database.SaveResult[] results = Database.insert(accounts, false);
    for(Database.SaveResult result : results){
        if(result.isSuccess()){
            //result.getId();
        } else {
            Database.Error[] errors = result.getErrors();
        }
    }


    try {
        insert accounts;
    } catch(Exception ex){
        //create a log
    }

//Trigger
Trigger AccountTrigger on Account(before insert, after insert, before update, after update, before delete, after delete, after undelete){
    if(Trigger.isBefore){
        if(Trigger.inInsert){
            AccountHandler.beforeInsert();
        } else if(Trigger.isUpdate){

        } else if(Trigger.isDelete){

        }
    }
    if(Trigger.isAfter){
        if(Trigger.inInsert){

        } else if(Trigger.isUpdate){

        } else if(Trigger.isDelete){

        } else {

        }
    }
}

public with sharing class AccountHandler{
    public static Boolean isBeforeInsertFirstRun = false;
    public static void beforeInsert(){
        if(!isBeforeInsertFirstRun){
            isBeforeInsertFirstRun = true;
            //execute business logic
        }
    }
    public static void beforeUpdate(){
        
    }
    public static void beforeDelete(){
        
    }
    public static void afterInsert(){

    }
    public static void afterUpdate(){
        
    }
    public static void afterDelete(){
        
    }
    public static void afterUndelete(){

    }
}


OpportunityReminderBatch batchable = new OpportunityReminderBatch();
Database.executeBatch(batchable); //scope:200
Database.executeBatch(batchable, 3000); //scope:10; 1-2000


public with sharing class MyMixedClass implements Database.Batchable<sObject>, Scheduable, Queueable {
    public Database.QueryLocator start(BatchableContext bc){

    }
    public void execute(BatchableContext bc, List<sObject> scope){

    }
    public void finish(BatchableContext bc){

    }
    public void execute(SchedulableContext sc){

    }
    public void execute(QueueableContext qc){
        
    }
}

There will be total 4 ways to run test classes while deployment - 
1. Do not run tests
2. Run specified test classes
3. Run all local tests 
4. Run all tests 


List<Account> accounts = [SELECT Id, Name, Type, Industry FROM Account WHERE AnnualRevenue > 2000000];
for(Account acc : accounts){
    
}
