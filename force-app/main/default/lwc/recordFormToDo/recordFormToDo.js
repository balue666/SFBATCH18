import { LightningElement } from 'lwc';
import TODO_OBJECT from '@salesforce/schema/ToDo__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordFormToDo extends LightningElement {
    objectName = TODO_OBJECT;
    recordId = 'a055h00001YzLQ3AAN';

    successHandler() {
        const toast = new ShowToastEvent({
            title: 'Success',
            message: 'ToDo record has been updated successfully',
            variant: 'success'
        });
        this.dispatchEvent(toast);
    }
}