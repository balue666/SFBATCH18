/** JSON FORMAT **/
/** JSON: JavaScript Object Notation **/
//Single record as JSON
{
    "Id": "0015h00001UrmLxAAJ",
    "Name": "TestACC",
    "AnnualRevenue": 6000000,
    "Type" : "New Account",
    "Industry" : "Biotechnoloty"
}

//Multiple records as JSON
[
    {
        "Id": "0065h00000MmSwBAAV",
        "Name": "Burlington Textiles Corp of America Opp",
        "Amount": 6000000,
        "StageName": "Closed Won",
        "CloseDate": "2023-10-03"
    },
    {
        "Id": "0065h00000MYMnFAAX",
        "Name": "Edge SLA",
        "Type": "Existing Customer - Upgrade",
        "Amount": 60000,
        "StageName": "Closed Won",
        "CloseDate": "2014-08-25"
    }
]

//1. Get an account having annual revenue greater than 5M. Convert the same into json format
Account acc = [SELECT Id, Name, Type, Industry, AnnualRevenue
            FROM Account
            WHERE AnnualRevenue > 5000000
            LIMIT 1];
String jsonString = JSON.serialize(acc);
System.debug(jsonString);

//2. Get a contact whose name contains "Rose". Convert the same into json format (FirstName, LastName, Email, Title, Department)
Contact con = [SELECT FirstName, LastName, Email, Title, Department
            FROM Contact
            WHERE Name LIKE '%Rose%'
            LIMIT 1];
String jsonString = JSON.serialize(con);
System.debug(jsonString);

//3. Get top 5 accounts based on ther annual revenue. Convert them into json format
List<Account> accs = [SELECT Id, Name, Type, Industry, AnnualRevenue
            FROM Account
            WHERE AnnualRevenue != null
            ORDER BY AnnualRevenue DESC
            LIMIT 5];
String jsonString = JSON.serialize(accs);
System.debug(jsonString);

//4. Get all the opportunity in the Closed Won stage and convert them into json format (Id, Name, Type, Amount, StageName, CloseDate)
List<Opportunity> opps = [SELECT Id, Name, Type, Amount, StageName, CloseDate
                    FROM Opportunity
                    WHERE StageName = 'Closed Won'];
String jsonString = JSON.serialize(opps);
System.debug(jsonString);


/** XML - Extensible Markup Language */
<Account>
    <Id>0015h00001UrmLxAAJ</Id>
    <Name>TestACC</Name>
    <AnnualRevenue>6000000</AnnualRevenue>
    <Type>New Account</Type>
    <Industry>Biotechnoloty</Industry>
</Account>

<Accounts>
    <Account>
        <Id>0015h00001UrmLxAAJ</Id>
        <Name>TestACC</Name>
        <AnnualRevenue>6000000</AnnualRevenue>
        <Type>New Account</Type>
        <Industry>Biotechnoloty</Industry>
    </Account>
    <Account>
        <Id>0015h00001UrmLxAAJ</Id>
        <Name>TestACC</Name>
        <AnnualRevenue>6000000</AnnualRevenue>
        <Type>New Account</Type>
        <Industry>Biotechnoloty</Industry>
    </Account>
</Accounts>



//Test Callouts
RestCallouts.getAnimals();
RestCallouts.getProducts();
RestCallouts.getAirlines();
RestCallouts.getRandomRecipe();
RestCallouts.getCaseFromOrg2();

ParksCallout.getParksByCountry('United States');
CalculatorCallouts.addNumbers(20,30);
CalculatorCallouts.multiplyNumbers(20,30);
CalculatorCallouts.divideNumbers(30,20);