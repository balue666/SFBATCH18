public with sharing class OpportunityCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOppsByStage(String stage){
        return [SELECT Id, Name, Type, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE StageName = :stage
            WITH SECURITY_ENFORCED];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpps() {
        return [SELECT Id, Name, Type, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE Amount != null
            WITH SECURITY_ENFORCED
            ORDER BY Amount DESC];
    }
}