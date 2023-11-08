@isTest
public with sharing class RestCalloutsMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        //we need to prepare fake responses and return the same
        //Get Animals
        if(request.getMethod() == 'GET' && request.getEndpoint() == 'https://th-apex-http-callout.herokuapp.com/animals') {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setStatus('OK');
            String body = '{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}';
            response.setBody(body);
            return response;
        }
        //Get Products
        else if(request.getMethod() == 'GET' && request.getEndpoint() == 'https://dummyjson.com/products') {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setStatus('OK');
            String body = '{"products":[{"id":1,"title":"iPhone 9","description":"An apple mobile which is nothing like apple","price":549,"discountPercentage":12.96,"rating":4.69,"stock":94,"brand":"Apple","category":"smartphones","thumbnail":"https://i.dummyjson.com/data/products/1/thumbnail.jpg","images":["https://i.dummyjson.com/data/products/1/1.jpg","https://i.dummyjson.com/data/products/1/2.jpg","https://i.dummyjson.com/data/products/1/3.jpg","https://i.dummyjson.com/data/products/1/4.jpg","https://i.dummyjson.com/data/products/1/thumbnail.jpg"]}]}';
            response.setBody(body);
            return response;
        }
        //Post ToDo
        else if(request.getMethod() == 'POST' && request.getEndpoint() == 'https://dummyjson.com/todos/add') {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(201);
            response.setStatus('Created');
            String body = '{"id": 151, "todo": "Use DummyJSON in the project", "completed": false, "userId": 5}';
            response.setBody(body);
            return response;
        }
        //Update Ecom Product
        else if(request.getMethod() == 'PUT' && request.getEndpoint().contains('https://dummyjson.com/products/')) {
            HttpResponse response = new HttpResponse();
            response.setStatusCode(200);
            response.setStatus('OK');
            String body = '{"id": 1, "title": "iPhone Galaxy +1", "description": "An apple mobile which is nothing like apple", "price": 549, "discountPercentage": 12.96, "rating": 4.69, "stock": 94, "brand": "Apple", "category": "smartphones", "thumbnail": "...","images": ["...", "...", "..."]}';
            response.setBody(body);
            return response;
        }
        return null;
    }
}