@isTest
public with sharing class RestCalloutsTest {
    
    @isTest
    private static void getAnimalsTest() {
        Test.startTest();
        //1. Set mock
        RestCalloutsMock mock = new RestCalloutsMock();
        Test.setMock(HttpCalloutMock.class, mock);

        //2. Call business method
        HttpResponse response = RestCallouts.getAnimals();

        //3. Perform asserts
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('OK', response.getStatus());
        Test.stopTest();
    }
}
