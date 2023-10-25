trigger CaseTrigger on Case (after update) {
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            //call the handler method
            CaseHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
}