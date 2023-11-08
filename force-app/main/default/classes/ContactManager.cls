@RestResource(urlMapping='/Contact/*')
global with sharing class ContactManager {
    
    //'https://sfdeveloper18-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Contact/*'

    @HttpGet
    global static Contact getContactById() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        try {
            Id conId = endpoint.subString(index+1);
            Contact con = [SELECT Id, FirstName, LastName, Email, Title, Department FROM Contact WHERE Id = :conId LIMIT 1];
            return con;
        } catch(Exception ex) {
            throw new RecordNotFoundException('Please send a valid contact id in the request uri.');
        }
    }

    @HttpPost
    global static Id createContact(String FirstName, String LastName, String Email, String Title, String Department) {
        Contact con = new Contact();
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Email = Email;
        con.Title = Title;
        con.Department = Department;
        insert con;
        return con.Id;
    }

    @HttpDelete
    global static String deleteContact() {
        RestRequest request = RestContext.request;
        String endpoint = request.requestURI;
        Integer index = endpoint.lastIndexOf('/');
        try {
            Id conId = endpoint.subString(index+1);
            Contact con = [SELECT Id FROM Contact WHERE Id = :conId LIMIT 1];
            delete con;
            return 'Success';
        } catch(Exception ex) {
            throw new RecordNotFoundException('Please send a valid contact id in the request uri.');
        }
    }

    @HttpPut
    global static Contact upsertContact() {
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        Contact con = (Contact)JSON.deserialize(body, Contact.class);
        upsert con;
        return con;
    }

    @HttpPatch
    global static Contact updateContact() {
        RestRequest request = RestContext.request;
        String body = request.requestBody.toString();
        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped(body);
        Contact con = new Contact();
        for(String fieldName : data.keySet()) {
            con.put(fieldName, data.get(fieldName)); //con.put('FirstName', 'Test') // con.FirstName = 'Test'
        }
        try {
            update con;
            Contact updatedCon = [SELECT Id, FirstName, LastName, Email, Title, Department FROM Contact WHERE Id = :con.Id LIMIT 1];
            return updatedCon;
        } catch(Exception ex) {
            throw new RecordNotFoundException('Please send a valid contact id in the request body.');
        }
    }
}