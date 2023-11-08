@isTest
public with sharing class RestCalloutsTest {

    @TestSetup
    private static void makeData() {
        //Create an ecom product record
        Ecommerce_Product__c prod = new Ecommerce_Product__c();
        prod.Name = 'iPhone 15';
        prod.Price__c = 1500;
        prod.Discount_Percentage__c = 4.50;
        prod.Stock__c = 1000;
        prod.Category__c = 'Smartphone';
        insert prod;
    }
    
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

    @isTest
    private static void getProductsTest() {
        Test.startTest();
        //1. Set mock
        RestCalloutsMock mock = new RestCalloutsMock();
        Test.setMock(HttpCalloutMock.class, mock);

        //2. Call business method
        HttpResponse response = RestCallouts.getProducts();

        //3. Perform asserts
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('OK', response.getStatus());
        Test.stopTest();
    }

    @isTest
    private static void postToDoTest() {
        Test.startTest();
        //1. Set mock
        RestCalloutsMock mock = new RestCalloutsMock();
        Test.setMock(HttpCalloutMock.class, mock);

        //2. Call business method
        ToDo__c todo = new ToDo__c();
        todo.Name = 'Use DummyJSON in the project';
        todo.Completed__c = false;
        todo.User_ID__c = 52;
        insert todo;

        Test.stopTest();
    }

    @isTest
    private static void updateProductTest() {
        Test.startTest();
        //1. Set mock
        RestCalloutsMock mock = new RestCalloutsMock();
        Test.setMock(HttpCalloutMock.class, mock);

        //2. Call business method
        Ecommerce_Product__c prod = [SELECT Id, Stock__c FROM Ecommerce_Product__c LIMIT 1];
        prod.Stock__c = 500;
        update prod;

        Test.stopTest();
    }
}