@RestResource(urlMapping='/sobject/*')
global with sharing class SobjectManager {
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/sobject/*'

    @HttpGet
    global static SObject getDetails() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        try {
            Id recordId = endpoint.subString(index+1);
            String apiName = recordId.getSObjectType().getDescribe().getName();
            if(apiName == 'Account') {
                Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating,
                                (SELECT Id, Name, Email, Title, Department FROM Contacts),
                                (SELECT Id, Subject, Description, Priority, Status FROM Cases),
                                (SELECT Id, Name, Type, StageName, Amount, CloseDate FROM Opportunities)
                                FROM Account
                                WHERE Id = :recordId
                                LIMIT 1];
                return acc;
            } else if(apiName == 'Contact') {
                Contact con = [SELECT Id, Name, Email, Title, Department, Account.Name, Account.AnnualRevenue FROM Contact WHERE Id = :recordId LIMIT 1];
                return con;
            } else if(apiName == 'Case') {
                Case cs = [SELECT Id, Subject, Description, Priority, Status, Account.Name, Account.AnnualRevenue FROM Case WHERE Id = :recordId LIMIT 1];
                return cs;
            } else if(apiName == 'Opportunity') {
                Opportunity opp = [SELECT Id, Name, Type, StageName, Amount, CloseDate, Account.Name, Account.AnnualRevenue FROM Opportunity WHERE Id = :recordId LIMIT 1];
                return opp;
            } else {
                throw new RecordNotFoundException('we handle only account, contact, case and opportunities.');
            }
        } catch(Exception ex) {
            throw new RecordNotFoundException(ex.getMessage());
        }
    }
}