public with sharing class CaseHandler {

    private static final String STATUS_CLOSED = 'Closed';

    public static void afterUpdate(Map<Id,Case> oldCases, Map<Id,Case> newCases) {
        List<Case_Closure__e> closures = new List<Case_Closure__e>();

        for(Id caseId : newCases.keySet()) {
            Case oldCase = oldCases.get(caseId);
            Case newCase = newCases.get(caseId);
            //Check if the status is changed and it is changed to Closed
            if(oldCase.Status != newCase.Status && newCase.Status == STATUS_CLOSED) {
                //Create a platform event
                Case_Closure__e closure = new Case_Closure__e();
                closure.Case_Number__c = newCase.CaseNumber;
                closure.Case_Subject__c = newCase.Subject;
                closure.Description__c = newCase.Description;
                closure.Email__c = newCase.ContactEmail;
                closures.add(closure);
            }
        }

        //publish platform events
        if(!closures.isEmpty()) {
            System.debug('Before publishing the platform events');
            EventBus.publish(closures);
            System.debug('After publishing the platform events');
        }
    }
}