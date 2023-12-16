public with sharing class SFACallouts {
    
    public static void getEcomProducts(){
        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://dummyjson.com/products');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200){
            String jsonString = response.getBody();
            EcomProductWrapper responseWrap = (EcomProductWrapper)JSON.deserialize(jsonString, EcomProductWrapper.class);
            List<EcomProductWrapper.EcomProduct> productWraps = responseWrap.products;
            List<Ecommerce_Product__c> records = new List<Ecommerce_Product__c>();
            for(EcomProductWrapper.EcomProduct productWrap : productWraps){
                records.add(convertWrapper(productWrap));
            }
            try {
                insert records;
            } catch(Exception ex){
                System.debug(ex.getMessage());
            }
        }
    }

    //method to convert a wrapper into sobject
    private static Ecommerce_Product__c convertWrapper(EcomProductWrapper.EcomProduct prod){
        Ecommerce_Product__c ecom = new Ecommerce_Product__c();
        ecom.Product_Id__c = prod.id;
        ecom.Name = prod.title;
        ecom.Description__c = prod.description;
        ecom.Price__c = prod.price;
        ecom.Discount_Percentage__c = prod.discountPercentage;
        ecom.Rating__c = prod.rating;
        ecom.Stock__c = prod.stock;
        ecom.Brand__c = prod.brand;
        ecom.Category__c = prod.category;
        ecom.Thumbnail__c = prod.thumbnail;
        return ecom;
    }
}