@isTest
public with sharing class AccountManagerTest {
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Account/*'
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Account/0015h00001SybD1AAJ'

    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com' //Base URL: System.URL.getSalesforceBaseURL().toExternalForm()
    //'/services/apexrest/Account/' //Common Place where all the REST API are stored + Rest URI of our WS
    //'0015h00001SybD1AAJ' //An Account ID

    @TestSetup
    private static void makeData() {
        //create account records
        List<Account> accounts = new List<Account>();
        for(Integer i=1; i<=2; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Type = 'New Customer';
            acc.Industry = 'Energy';
            acc.AnnualRevenue = 1000000 * i;
            acc.Rating = 'Hot';
            accounts.add(acc);
        }
        insert accounts;
    }

    @isTest
    private static void getAccountByIdTest() {
        //Prepare inputs
        Account acc = [SELECT Id, Name, AnnualRevenue FROM Account LIMIT 1];
        String method = 'GET';
        String endpoint = System.URL.getSalesforceBaseURL().toExternalForm() + '/services/apexrest/Account/' + acc.Id;

        Test.startTest();
        RestRequest request = new RestRequest();
        request.httpMethod = method;
        request.requestURI = endpoint;
        RestContext.request = request;

        //Invoke business method
        Account receivedAcc = AccountManager.getAccountById();

        //Perform assertions
        Assert.areEqual(receivedAcc.Name, acc.Name);
        Assert.areEqual(receivedAcc.AnnualRevenue, acc.AnnualRevenue);
        Test.stopTest();
    }

    @isTest
    private static void postAccountTest() {
        Test.startTest();
        //Invoke business method
        String accId = AccountManager.postAccount('Test Acc', 'New Customer', 'Education', 3000000, 'Warm');

        //Perform assertions
        Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating FROM Account WHERE Id = :accId LIMIT 1];
        Assert.areEqual(acc.Name, 'Test Acc');
        Assert.areEqual(acc.AnnualRevenue, 3000000);
        Test.stopTest();
    }

    @isTest
    private static void deleteAccountTest() {
        //Prepare inputs
        Account acc = [SELECT Id, Name, AnnualRevenue FROM Account LIMIT 1];
        String method = 'DELETE';
        String endpoint = System.URL.getSalesforceBaseURL().toExternalForm() + '/services/apexrest/Account/' + acc.Id;

        Test.startTest();
        RestRequest request = new RestRequest();
        request.httpMethod = method;
        request.requestURI = endpoint;
        RestContext.request = request;

        //Invoke business method
        String result = AccountManager.deleteAccount();

        //Perform assertions
        Assert.areEqual('Success', result);
        Test.stopTest();
    }

    @isTest
    private static void putAccountTest() {
        //Prepare inputs
        String method = 'PUT';
        Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue, Rating FROM Account LIMIT 1];
        acc.AnnualRevenue = 4000000;
        String body = JSON.serialize(acc);

        Test.startTest();
        RestRequest request = new RestRequest();
        request.httpMethod = method;
        request.requestBody = Blob.valueOf(body);
        RestContext.request = request;

        //Invoke business method
        Account updatedAcc = AccountManager.putAccount();

        //Perform assertions
        Assert.areEqual(4000000, updatedAcc.AnnualRevenue);
        Test.stopTest();
    }

    @isTest
    private static void patchAccountTest() {
        //Prepare inputs
        String method = 'PATCH';
        Account acc = [SELECT Id, AnnualRevenue FROM Account LIMIT 1];
        acc.AnnualRevenue = 4000000;
        String body = JSON.serialize(acc);
        System.debug(body);

        Test.startTest();
        RestRequest request = new RestRequest();
        request.httpMethod = method;
        request.requestBody = Blob.valueOf(body);
        RestContext.request = request;

        //Invoke business method
        Account updatedAcc = AccountManager.patchAccount();

        //Perform assertions
        Assert.areEqual(4000000, updatedAcc.AnnualRevenue);
        Test.stopTest();
    }
}