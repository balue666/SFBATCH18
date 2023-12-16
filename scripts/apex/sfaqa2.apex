/**
 * HW-7/2
Name              : Summer Fest LLC
Parent Account    : University of Arizona //Pending
Type              : Technology Partner
Rating            : Hot
Annual Revenue    : 200,000,000
Description       : Custom label was used when creating this account. //Pending
 */

//Get the account University of Arizona
Account universityAccount = [SELECT Id, Name FROM Account WHERE Name = 'University of Arizona' LIMIT 1];

//Create account
Account acc = new Account();
acc.Name = 'Summer Fest LLC';
acc.Type = 'Technology Partner';
acc.Rating = 'Hot';
acc.AnnualRevenue = 200000000;
acc.ParentId = universityAccount.Id;
acc.Description = Label.Summary_Fest_Desc;
insert acc;

Account parentAcc = [SELECT Id, Name, (SELECT Id, Name FROM ChildAccounts) FROM Account WHERE Name = 'University of Arizona' LIMIT 1];
System.debug('Parent Account: ' + parentAcc.Name);
List<Account> childrenAccounts = parentAcc.ChildAccounts;
for(Account acc : childrenAccounts) {
    System.debug('Child Account: ' + acc.Name);
}

SFACallouts.getEcomProducts();


Entry => When Ecom product record is getting created without Product ID populated
Write a trigger, which calls a handler method. while iterating over the records in handler, call a future method;

future method takes 18 digit record id as input.
    1. Query for the entire record data.
    2. Convert the record into wrapper. wrapper into json
    3. prepare http request & set everything there including this json body
    4. internet
    5. send the request over http
    6. process the response
