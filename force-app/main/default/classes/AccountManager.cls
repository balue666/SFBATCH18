@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Account/*'
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Account/0015h00001SybD1AAJ'

    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        Id accId = endpoint.subString(index+1); //0015h00001SybD1AAJ
        try {
            Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating FROM Account WHERE Id = :accId];
            return acc;
        } catch(Exception ex) {
            //throw exception
            throw new RecordNotFoundException('Record not found. Plese send a valid account id in your request.');
        }
    }

    @HttpPost
    global static String postAccount(String Name, String Type, String Industry, Integer AnnualRevenue, String Rating) {
        Account acc = new Account();
        acc.Name = Name;
        acc.Type = Type;
        acc.Industry = Industry;
        acc.AnnualRevenue = AnnualRevenue;
        acc.Rating = Rating;
        insert acc;
        return acc.Id;
    }

    @HttpDelete
    global static String deleteAccount() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        try {
            Id accId = endpoint.subString(index+1);
            Account acc = [SELECT Id FROM Account WHERE Id = :accId];
            delete acc;
            return 'Success';
        } catch(Exception ex) {
            return ex.getMessage();
        }
    }

    @HttpPut
    global static Account putAccount() {
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        Account acc = (Account)JSON.deserialize(body, Account.class);
        upsert acc;
        return acc;
    }

    @HttpPatch
    global static Account patchAccount() {
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        Map<String, Object> data = (Map<String, Object>)JSON.deserializeUntyped(body);
        System.debug(data);
        Account acc = new Account();
        for(String key : data.keySet()) {
            if(key != 'attributes') {
                acc.put(key, data.get(key)); //acc.Name = 'Test Account'; //acc.put('Name', 'Test Account');
            }
        }
        try {
            update acc;
            Account updatedAcc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating FROM Account WHERE Id = :acc.Id LIMIT 1];
            return updatedAcc;
        } catch(Exception ex) {
            throw new RecordNotFoundException('Account record not found. Please input a valid id in the body of the request.');
        }
    }


    //Regular SOQL
    List<Account> accounts = [SELECT Id, Name, Type, Industry, AccountNumber FROM Account WHERE AccountNumber = null]; //20,000 // 3MB
    for(Account acc : accounts){
        if(acc.Industry == 'Education'){
            acc.AccountNumber = 'EDU012345';
        }
    }
    update accounts;

    //SOQL For Loop
    List<Account> accounts = new List<Account>();
    for(Account acc : [SELECT Id, Name, Type, Industry, AccountNumber FROM Account WHERE AccountNumber = null]){ //201-400 //0.03MB
        if(acc.Industry == 'Education'){
            acc.AccountNumber = 'EDU012345';
        }
        accounts.add(acc);
    }
    update accounts;
    
}