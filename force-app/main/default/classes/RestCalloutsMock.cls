@isTest
public with sharing class RestCalloutsMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        //we need to prepare fake responses and return the same
        if(request.getMethod() == 'GET' && request.getEndpoint() == 'https://th-apex-http-callout.herokuapp.com/animals') {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setStatus('OK');
            String body = '{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}';
            response.setBody(body);
            return response;
        }
        return null;
    }
}
