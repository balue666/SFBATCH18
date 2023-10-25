public with sharing class SpoonacularCallouts {

    private static final String API_KEY = 'API Key';
    private static final String RANDOM_RECIPE = 'Get Random Recipe';
    private static final String RECIPE_BY_INGREDIENTS = 'Search Recipe by Ingredients';
    private static final String RECIPE_DETAILS = 'Get Recipe Details';
    
    @AuraEnabled
    public static String getRandomRecipe() {
        //1. Prepare HttpRequest and wrap all the necessary data in it
        String endpoint = MetadataHandler.getSpoonacularDetail(RANDOM_RECIPE);
        String apiKey = MetadataHandler.getSpoonacularDetail(API_KEY);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + '?apiKey=' + apiKey); //https://api.spoonacular.com/recipes/random?apiKey=92f4809a9d74483b9b93f7a644ce83c1
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive response
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
            return response.getBody();
        }
        return '';
    }

    @AuraEnabled
    public static String searchRecipeByIngredients(String ingr) {
        //1. Prepare HttpRequest and wrap all the necessary data in it
        String apiKey = MetadataHandler.getSpoonacularDetail(API_KEY);
        String endpoint = MetadataHandler.getSpoonacularDetail(RECIPE_BY_INGREDIENTS);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + '?ingredients=' + ingr + '&apiKey=' + apiKey); //https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples&apiKey=92f4809a9d74483b9b93f7a644ce83c1
        request.setMethod('GET'); 

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet in order to receive response
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
            return response.getBody();
        }
        return '';
    }

    @AuraEnabled
    public static String getRecipeDetails(String recipeId) {
        //1. Prepare HttpRequest and wrap all the necessary data in it
        String apiKey = MetadataHandler.getSpoonacularDetail(API_KEY);
        String endpoint = MetadataHandler.getSpoonacularDetail(RECIPE_DETAILS).replace('{id}', recipeId);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + '?apiKey=' + apiKey); //https://api.spoonacular.com/recipes/12345/information?apiKey=92f4809a9d74483b9b93f7a644ce83c1
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();
        
        //3. Send the request over the internet in order to receive response
        HttpResponse response = http.send(request);

        //4. Process the response
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
            return response.getBody();
        }
        return '';
    }
}