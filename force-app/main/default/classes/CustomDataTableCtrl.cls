public with sharing class CustomDataTableCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(){
        return [SELECT Id, Name FROM Account];
    }

    @AuraEnabled
    public static List<Contact> getContacts(Id accId) {
        return [SELECT Id, Name, Email, Phone FROM Contact WHERE AccountId = :accId];
    }

    @AuraEnabled
    public static string updateContacts(Object data) {
        List<Contact> contactsForUpdate = (List<Contact>) JSON.deserialize(JSON.serialize(data),List<Contact>.class);
        try {
            update contactsForUpdate;
            return 'Success: contacts updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}