public with sharing class EmployeeCallouts {
    
    @future(callout=true)
    public static void sendEmployeeDetails(Id empId) {
        //Get the record and convert it into json
        Employee__c emp = [SELECT Id, First_Name__c, Last_Name__c, Maiden_Name__c, Age__c, Email__c, Gender__c, Integration_Status__c, Employee_ID__c, Phone_Number__c FROM Employee__c WHERE Id = :empId LIMIT 1];
        EmployeeWrapper wrap = new EmployeeWrapper();
        wrap.firstName = emp.First_Name__c;
        wrap.lastName = emp.Last_Name__c;
        wrap.maidenName = emp.Maiden_Name__c;
        wrap.age = Integer.valueOf(emp.Age__c);
        wrap.gender = emp.Gender__c;
        wrap.email = emp.Email__c;
        wrap.phone = emp.Phone_Number__c;
        String body = JSON.serialize(wrap);

        //1. Create HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://dummyjson.com/users/add');
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        String jsonString = response.getBody();
        emp.Integration_Status__c = response.getStatusCode() + '\n' + jsonString;
        update emp;
    }
}