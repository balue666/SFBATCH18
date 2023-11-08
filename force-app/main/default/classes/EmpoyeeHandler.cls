public with sharing class EmpoyeeHandler {
    public static void afterInsert(List<Employee__c> newEmps) {
        for(Employee__c emp : newEmps) {
            EmployeeCallouts.sendEmployeeDetails(emp.Id);
        }
    }
}