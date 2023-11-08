public with sharing class EcomProductHandler {
    public static void afterUpdate(Map<Id,Ecommerce_Product__c> oldProducts, Map<Id,Ecommerce_Product__c> newProducts) {
        for(Id prodId : newProducts.keySet()) {
            Ecommerce_Product__c oldProduct = oldProducts.get(prodId);
            Ecommerce_Product__c newProduct = newProducts.get(prodId);
            if(oldProduct.Price__c != newProduct.Price__c || oldProduct.Discount_Percentage__c != newProduct.Discount_Percentage__c || oldProduct.Rating__c != newProduct.Rating__c || oldProduct.Stock__c != newProduct.Stock__c) {
                RestCallouts.updateProduct(newProduct.Id);
            }
        }
    }

    public static void afterDelete(List<Ecommerce_Product__c> products) {
        for(Ecommerce_Product__c prod : products) {
            RestCallouts.deleteProduct(Integer.valueOf(prod.Product_Id__c));
        }
    }
}