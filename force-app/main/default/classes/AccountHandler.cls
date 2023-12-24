public with sharing class AccountHandler {
    public static void beforeInsert(List<Account> newAccounts){
        updateRating(newAccounts, null);
    }
    public static void beforeUpdate(List<Account> newAccounts, List<Account> oldAccounts){
        updateRating(newAccounts, oldAccounts);
    }

    private static void updateRating(List<Account> newAccounts, List<Account> oldAccounts){
        if(oldAccounts == null){
            for(Account acc : newAccounts){
                if(acc.Industry == 'Media'){
                    acc.Rating = 'Hot';
                }
            }
        } else {
            for(Integer i=0; i<newAccounts.size(); i++){
                if(newAccounts[i].Industry == 'Media' && newAccounts[i].Industry != oldAccounts[i].Industry){
                    acc.Rating = 'High';
                }
            }
        }
    }
}
