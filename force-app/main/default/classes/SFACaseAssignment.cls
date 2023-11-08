public with sharing class SFACaseAssignment {

    public static void caseInsert(List<Account> accList) {
        List<Case> caseList = new List<Case>();
        for (Account acc : accList) {
            case cs = new case();
            cs.Subject = 'Testcase' +acc.name;
            cs.Origin = 'Phone';
            cs.AccountId = acc.Id;
            caseList.add(cs);
        }
        insert caseList;
    }

    public static void caseUpdate(List<Case> csList){
        for (Case cs : csList) {
            cs.Subject ='Updated case';
        }
        update csList;
    }

    public static void caseDelete(){
        case cs = [SELECT Id,Subject 
                FROM Case WHERE Subject LIKE '%Case 1%' LIMIT 1];
        delete cs;
    }

}