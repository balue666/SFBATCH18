public with sharing class SFAAccountHandler {
    public static Boolean isAfterInsertExecuted = false;

    public static void afterInsert(List<Account> newAccounts) {
        for(Account acc : newAccounts) {
            acc.Description = acc.Name + ' ' + acc.CreatedDate;
        }
        isAfterInsertExecuted = true;
        update newAccounts;
    }
}
