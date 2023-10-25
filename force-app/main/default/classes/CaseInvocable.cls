public with sharing class CaseInvocable {
    
    public static void saveAndSendEmail(List<InputRequest> requests) {
        
    }

    public class InputRequest {
        @InvocableVariable(label='Case Number' description='Case Number' required=true)
        public String caseNumber;

        @InvocableVariable(label='Contact Id' description='Contact Id' required=true)
        public String contactId;
    }
}
