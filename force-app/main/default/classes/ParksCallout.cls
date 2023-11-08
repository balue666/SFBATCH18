public with sharing class ParksCallout {
    
    //callout to get the parks based on country
    public static void getParksByCountry(String country) {
        ParksServices.ParksImplPort service = new ParksServices.ParksImplPort();
        String[] parks = service.byCountry(country);
        System.debug(parks);
    }
}