public with sharing class PetCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Pet__c> getAllPets() {
        return [SELECT Name, Breed__c, Description__c, Height__c, Image__c, Life_Span__c, More_Info__c, Weight__c
        FROM Pet__c
        WITH SECURITY_ENFORCED
        ORDER BY Breed__c];
    }
}