trigger CaseTrigger on Case (after update) {
    Manage_Triggers__c setting = Manage_Triggers__c.getInstance(UserInfo.getUserId());
    if(setting != null && setting.Bypass_Triggers__c == true){
        return;
    }
    
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            //call the handler method
            CaseHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
        }
    }
}