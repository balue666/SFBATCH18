public with sharing class MetadataHandler {
    
    /*
    Recieves metdata label as input, converts that into developer name
    returns the value
    */
    public static String getSpoonacularDetail(String key) {
        key = key.replace(' ', '_');
        Spoonacular_Detail__mdt detail = Spoonacular_Detail__mdt.getInstance(key);
        return detail.Value__c;
    }
}