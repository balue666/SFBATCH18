public with sharing class AccountCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getTopAccounts(){
        //try making a dml
        Account acc = new Account(Name='Test Account');
        insert acc;

        return [SELECT Id, Name, Type, Industry, AnnualRevenue
            FROM Account
            WHERE AnnualRevenue != null //If we dont take it, the record with null values comes first
            WITH SECURITY_ENFORCED
            ORDER BY AnnualRevenue
            LIMIT 5];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(){
        return [SELECT Id, Name, Type, Industry, AnnualRevenue
            FROM Account
            WHERE AnnualRevenue != null
            WITH SECURITY_ENFORCED
            ORDER BY AnnualRevenue DESC];
    }

    @AuraEnabled
    public static List<Account> getAccountsByIndustry(String industry){
        return [SELECT Id, Name, Type, Industry, AnnualRevenue
            FROM Account
            WHERE Industry = :industry
            WITH SECURITY_ENFORCED
            ORDER BY Name];
    }
}