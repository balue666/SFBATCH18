public with sharing class AssetHandler {
    public static void afterInsertUpdate(List<Asset__c> newAssets) {
        Set<Id> accountIds = new Set<Id>();
        for(Asset__c asset : newAssets) {
            if(asset.Account__c != null) {
                accountIds.add(asset.Account__c);
            }
        }

        if(!accountIds.isEmpty()) {
            List<Account> accountsToUpdate  = new List<Account>();
            List<Account> accounts = [SELECT Id, Total_Asset_Amount__c, (SELECT Id, Price__c FROM Assets__r) FROM Account WHERE Id IN :accountIds];
            for(Account acc : accounts) {
                Decimal total = 0.0;
                for(Asset__c asset : acc.Assets__r) {
                    total += asset.Price__c;
                }
                accountsToUpdate.add(new Account(Id=acc.Id, Total_Asset_Amount__c=total));
            }
            update accountsToUpdate;
        }
    }
}