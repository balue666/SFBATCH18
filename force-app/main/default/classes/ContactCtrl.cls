public with sharing class ContactCtrl {
    
    @AuraEnabled
    public static List<Contact> searchContacts(String searchKey){ // John --- Jo
        searchKey = '%' + searchKey + '%'; // %Jo%
        return [SELECT FirstName, LastName, Title, Department
            FROM Contact
            WHERE Name LIKE :searchKey
            WITH SECURITY_ENFORCED
            ORDER BY NAME];
    }
}