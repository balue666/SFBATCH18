trigger EmployeeTrigger on Employee__c (after insert) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            EmpoyeeHandler.afterInsert(Trigger.new);
        }
    }
}