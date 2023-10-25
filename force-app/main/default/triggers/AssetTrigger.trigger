trigger AssetTrigger on Asset__c (after insert) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            AssetHandler.afterInsertUpdate(Trigger.new);
        }
        if(Trigger.isUpdate) {
            AssetHandler.afterInsertUpdate(Trigger.new);
        }
        if(Trigger.isDelete) {

        }
    }
}