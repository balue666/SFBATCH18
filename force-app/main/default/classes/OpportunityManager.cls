@RestResource(urlMapping='/Opps/*')
global with sharing class OpportunityManager {
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Opps/*'
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Opps/0015h00001SybD1AAJ'

    @HttpGet
    global static Account getAccountOppsById() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        try {
            Id accId = endpoint.subString(index+1);
            Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating,
                            (SELECT Id, Name, Amount, Type, StageName, CloseDate FROM Opportunities)
                            FROM Account
                            WHERE Id = :accId
                            LIMIT 1];
            return acc;
        } catch(Exception ex) {
            throw new RecordNotFoundException('Please send a valid account id in the request uri.');
        }
    }
}