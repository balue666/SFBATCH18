import { LightningElement } from 'lwc';
import TODO_OBJECT from '@salesforce/schema/ToDo__c';
import NAME_FIELD from '@salesforce/schema/ToDo__c.Name';
import TODO_ID_FIELD from '@salesforce/schema/ToDo__c.ToDo_Id__c';
import USER_ID_FIELD from '@salesforce/schema/ToDo__c.User_ID__c';
import OWNER_FIELD from '@salesforce/schema/ToDo__c.OwnerId';
import COMPLETED_FIELD from '@salesforce/schema/ToDo__c.Completed__c';
import INT_FIELD from '@salesforce/schema/ToDo__c.Integration_Status__c';

export default class RecordViewFormToDo extends LightningElement {
    objectName = TODO_OBJECT;
    recordId = 'a055h00001YzLQ3AAN';
    fields = {
        name: NAME_FIELD,
        todoId: TODO_ID_FIELD,
        userId: USER_ID_FIELD,
        owner: OWNER_FIELD,
        completed: COMPLETED_FIELD,
        intStatus: INT_FIELD
    };
}