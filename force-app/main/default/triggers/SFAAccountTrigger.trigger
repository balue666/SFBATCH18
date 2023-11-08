trigger SFAAccountTrigger on Account (after insert) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            if(isAfterInsertExecuted == false) {
                SFAAccountHandler.afterInsert(Trigger.new);
            }
        }
    }
}

/*
OBJECT: ACCOUNT
DML: INSERT
OPERATION: POPULATE A FIELD (DESCRIPTION) ON THE VERY SAME RECORD
TRIGGER TYPE: BEFORE
*/