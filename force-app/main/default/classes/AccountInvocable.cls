public with sharing class AccountInvocable {
    @InvocableMethod(label='Close Opportunities'
    description='Close all the open opportunities under the given accounts'
    category='SI')
    public static void updateOpps(List<Id> accountIds) {
        List<Opportunity> opps = [SELECT Id, StageName FROM Opportunity WHERE AccountId IN :accountIds AND StageName NOT IN ('Closed Won', 'Closed Lost') WITH SECURITY_ENFORCED];
        for(Opportunity opp : opps) {
            opp.StageName = 'Closed Lost';
        }
        try {
            update opps;
        } catch(Exception ex) {
            //create log
        }
    }
}