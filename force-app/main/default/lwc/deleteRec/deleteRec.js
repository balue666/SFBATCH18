import { deleteRecord } from 'lightning/uiRecordApi';
import { LightningElement } from 'lwc';

export default class DeleteRec extends LightningElement {
    recId;
    changeHandler(event) {
        this.recId = event.target.value;
    }

    deleteHandler() {
        const recordId = this.recId;

        deleteRecord(recordId)
            .then(result => {
                window.alert('Successfully deleted');
            })
            .catch(error => {
                window.alert('Please enter a valid record id');
            })
    }
}