trigger EcomProductTrigger on Ecommerce_Product__c (after update, after delete) {
    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            EcomProductHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
        }
        if(Trigger.isDelete) {
            EcomProductHandler.afterDelete(Trigger.old);
        }
    }
}