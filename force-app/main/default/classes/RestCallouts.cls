public with sharing class RestCallouts {

    private static final String HTTP_GET = 'GET';
    private static final String HTTP_POST = 'POST';
    private static final String HTTP_PUT = 'PUT';
    private static final String HTTP_DELETE = 'DELETE';
    
    /**
     * get animals: GET
     * https://th-apex-http-callout.herokuapp.com/animals
     */
    public static HttpResponse getAnimals() {
        //1. Prepare HttpRequest and wrap all necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_GET);
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process response
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
        return response;
    }

    /**
     * Get Products: GET
     * https://dummyjson.com/products
     */
    public static HttpResponse getProducts() {
        //1. Prepare HttpRequest and wrap all necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_GET);
        request.setEndpoint('https://dummyjson.com/products');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive response
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            EcomWrapper wrapper = (EcomWrapper)JSON.deserialize(jsonString, EcomWrapper.class);
            List<EcomWrapper.ProductWrapper> products = wrapper.products;
            List<Ecommerce_Product__c> ecoms = new List<Ecommerce_Product__c>();
            for(EcomWrapper.ProductWrapper wrap : products) {
                Ecommerce_Product__c ecom = new Ecommerce_Product__c();
                ecom.Brand__c = wrap.brand;
                ecom.Category__c = wrap.category;
                ecom.Description__c = wrap.description;
                ecom.Discount_Percentage__c = wrap.discountPercentage;
                ecom.Price__c = wrap.price;
                ecom.Product_Id__c = wrap.id;
                ecom.Rating__c = wrap.rating;
                ecom.Stock__c = wrap.stock;
                ecom.Thumbnail__c = wrap.thumbnail;
                ecom.Name = wrap.title;
                ecoms.add(ecom);
            }
            insert ecoms;
        } else {
            System.debug(response.getBody());
        }
        return response;
    }

    /**
     * Get Airlines: GET
     * https://api.instantwebtools.net/v1/airlines/2
     */
    public static HttpResponse getAirlines() {
        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_GET);
        request.setEndpoint('https://api.instantwebtools.net/v1/airlines/2');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            AirlineWrapper wrapper = (AirlineWrapper)JSON.deserialize(jsonString, AirlineWrapper.class);
            //convert wrapper into sobject
            Airline__c airline = new Airline__c();
            airline.Name = wrapper.name;
            airline.Airlines_Id__c = wrapper.id;
            airline.Country__c = wrapper.country;
            airline.Established__c = wrapper.established;
            airline.Head_Quaters__c = wrapper.head_quaters;
            airline.Logo__c = wrapper.logo;
            airline.Slogan__c = wrapper.slogan;
            airline.Website__c = wrapper.website;
            insert airline;
        } else {
            System.debug(response.getBody());
        }
        return response;
    }

    /**
     * Get Random Recipe: GET
     * https://api.spoonacular.com/recipes/random?apiKey=f1f54551d76845b0889c2fc12f5c7322
     */
    public static String getRandomRecipe() {
        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_GET);
        request.setEndpoint('https://api.spoonacular.com/recipes/random?apiKey=f1f54551d76845b0889c2fc12f5c7322');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            System.debug(jsonString);
            return jsonString;
        }
        return '';
    }

    /**
     * Post ToDo: POST
     * https://dummyjson.com/todos/add
     */
    @future(callout=true)
    public static void postToDo(Id todoId) {
        //Collect all the data and prepare it as JSON
        ToDo__c todo = [SELECT Id, Name, Completed__c, ToDo_Id__c, User_ID__c FROM ToDo__c WHERE Id = :todoId LIMIT 1];
        ToDoWrapper wrap = new ToDoWrapper();
        //wrap.id = todo.ToDo_Id__c;
        wrap.todo = todo.Name;
        wrap.completed = todo.Completed__c;
        wrap.userId = Integer.valueOf(todo.User_ID__c);
        String body = JSON.serialize(wrap);

        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_POST);
        request.setEndpoint('https://dummyjson.com/todos/add');
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 201 || response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            ToDoWrapper toDoWrap = (ToDoWrapper)JSON.deserialize(jsonString, ToDoWrapper.class);
            todo.ToDo_Id__c = toDoWrap.id;
            update todo;
        } else {
            System.debug(response.getBody());
        }
    }

    /**
     * Update Product: PUT
     * https://dummyjson.com/products/{productId}     //1 is the product id
     */
    @future(callout=true)
    public static void updateProduct(Id prodId) {
        //Get the product details and prepare a json
        Ecommerce_Product__c prod = [SELECT Name, Brand__c, Category__c, Description__c, Discount_Percentage__c, Price__c, Product_Id__c, Rating__c, Stock__c, Thumbnail__c FROM Ecommerce_Product__c WHERE Id = :prodId LIMIT 1];
        EcomWrapper.ProductUpdateWrapper prodWrap = new EcomWrapper.ProductUpdateWrapper();
        prodWrap.title = prod.Name;
        prodWrap.brand = prod.Brand__c;
        prodWrap.category = prod.Category__c;
        prodWrap.description = prod.Description__c;
        prodWrap.discountPercentage = prod.Discount_Percentage__c;
        prodWrap.price = Integer.valueOf(prod.Price__c);
        //prodWrap.id = Integer.valueOf(prod.Product_Id__c);
        prodWrap.rating = prod.Rating__c;
        prodWrap.stock = Integer.valueOf(prod.Stock__c);
        prodWrap.thumbnail = prod.Thumbnail__c;
        String body = JSON.serialize(prodWrap);

        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_PUT);
        request.setEndpoint('https://dummyjson.com/products/' + prod.Product_Id__c);
        request.setBody(body);
        request.setHeader('Content-Type', 'application/json');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive response
        HttpResponse response = http.send(request);

        //4. Process the response
        prod.Description__c = prod.Description__c + '\n' + response.getStatusCode() + ' ' + response.getStatus();
        update prod;
    }

    /**
     * Delete Product: DELETE
     * https://dummyjson.com/products/{productId}
     */
    @future(callout=true)
    public static void deleteProduct(Integer prodId) {
        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_DELETE);
        request.setEndpoint('callout:NC_DummyJson/products/' + prodId);
        //request.setEndpoint('https://dummyjson.com/products/' + prodId);

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        System.debug(response.getStatusCode());
        System.debug(response.getStatus());
    }

    /**
     * Get Cases: GET
     * https://itte-dev-ed.my.salesforce.com/services/apexrest/Cases/5006F00003CKYzOQAX
     */
    public static void getCaseFromOrg2() {
        //1. Prepare HttpRequest and wrap all the necessary information
        HttpRequest request = new HttpRequest();
        request.setMethod(HTTP_GET);
        request.setEndpoint('callout:NC_Org1/services/apexrest/Cases/5006F00003CKYzOQAX');
        //request.setEndpoint('https://itte-dev-ed.my.salesforce.com/services/apexrest/Cases/5006F00003CKYzOQAX');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet to receive HttpResponse
        HttpResponse response = http.send(request);

        //4. Process the response
        System.debug(response.getStatusCode());
        System.debug(response.getBody());
    }
}