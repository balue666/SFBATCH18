trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountHandler.beforeInsert(Trigger.new);
        }
        if(Trigger.isUpdate){
            AccountHandler.beforeUpdate(Trigger.new, Trigger.old);
        }
    }
}