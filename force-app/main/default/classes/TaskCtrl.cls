public with sharing class TaskCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Task__c> getAllTasks(){
        return [SELECT Name, Due_Date__c, Status__c FROM Task__c WITH SECURITY_ENFORCED];
    }
}
