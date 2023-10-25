trigger ToDoTrigger on ToDo__c (after insert) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            ToDoHandler.afterInsert(Trigger.new);
        }
    }
}