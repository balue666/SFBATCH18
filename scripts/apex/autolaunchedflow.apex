Account acc = [SELECT Id, Name, OwnerId, CreatedBy.Name FROM Account WHERE Industry = 'Biotechnology' LIMIT 1];
System.debug(acc.Id);
Map<String,Object> inputs = new Map<String,Object>();
inputs.put('AccountId', acc.Id);
inputs.put('AccountName', acc.Name);
inputs.put('AccountOwnerId', acc.OwnerId);
inputs.put('CreatedByName', acc.CreatedBy.Name);
Flow.Interview flow = new Flow.Interview.Account_Autolaunched_Flow(inputs);
flow.start();