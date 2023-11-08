public with sharing class ToDoHandler {
    
    public static void afterInsert(List<ToDo__c> newToDos) {
        for(ToDo__c todo : newToDos) {
            RestCallouts.postToDo(todo.Id);
        }
    }
}