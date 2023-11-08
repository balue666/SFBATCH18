@isTest
public with sharing class SFACaseAssignmentTest {
    
    @TestSetup
    private static void makeData() {
        //make accounts
        List<Account> accounts = new List<Account>();
        for(Integer i=1; i<=10; i++) {
            Account acc = new Account();
            acc.Name = 'Test Account ' + i;
            acc.Type = 'New Customer';
            acc.Industry = 'Energy';
            accounts.add(acc);
        }
        insert accounts;

        //make cases
        List<Case> cases = new List<Case>();
        for(Integer i=1; i<=10; i++) {
            Case cs = new Case();
            cs.Subject = 'Case ' + i; //Case 1 //Case 2 //Case 3 ... //Case 10
            cs.Origin = 'Email';
            cs.Priority = 'High';
            cases.add(cs);
        }
        insert cases;
    }

    @isTest
    private static void caseInsertTest() {
        Test.startTest();
        List<Account> accounts = [SELECT Id, Name, Type, Industry FROM Account LIMIT 10];
        SFACaseAssignment.caseInsert(accounts);
        List<Case> createdCases = [SELECT Id FROM Case WHERE Subject LIKE '%Testcase%' AND Origin = 'Phone'];
        System.assertEquals(10, createdCases.size());
        Test.stopTest();
    }

    @isTest
    private static void caseUpdateTest() {
        Test.startTest();
        List<Case> cases = [SELECT Id, Subject FROM Case WHERE Subject != 'Case 1'];
        SFACaseAssignment.caseUpdate(cases);
        List<Case> casesAfterUpdate = [SELECT Id, Subject FROM Case WHERE Subject ='Updated case'];
        System.assertEquals(cases.size(), casesAfterUpdate.size());
        Test.stopTest();
    }

    @isTest
    private static void caseDeleteTest() {
        Test.startTest();
        List<Case> cases = [SELECT Id FROM Case WHERE Subject LIKE '%Case 1%'];
        System.assertEquals(2, cases.size());
        SFACaseAssignment.caseDelete();
        List<Case> casesAfterDelete = [SELECT Id FROM Case WHERE Subject LIKE '%Case 1%'];
        System.assertEquals(1, casesAfterDelete.size());
    }
}