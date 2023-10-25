import { LightningElement, track, wire } from 'lwc';
import getAllAccounts from '@salesforce/apex/CustomDataTableCtrl.getAllAccounts';
import getContacts from '@salesforce/apex/CustomDataTableCtrl.getContacts';
import updateContacts from "@salesforce/apex/CustomDataTableCtrl.updateContacts";
import { refreshApex } from "@salesforce/apex";
import { updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";

export default class CustomDataTable extends LightningElement {
    @track accounts;
    @track contacts;
    draftValues = [];
    @track columns = [
        { label: 'Name', fieldName: 'Name', type: 'text', editable: true },
        { label: 'Email', fieldName: 'Email', type: 'email', editable: true },
        { label: 'Phone', fieldName: 'Phone', type: 'phone', editable: true },
        { type: 'action', typeAttributes: { 
            rowActions: [
                { label: 'Edit', name: 'edit' }, 
                { label: 'Delete', name: 'delete' }
            ] 
        } }
    ];
    isEditMode = false;

    handleAddRecord() {
        const con = {Id: Math.random().toString, Name: '', Email: '', Phone: ''};
        this.contacts = [...this.contacts, con];
    }

    // handleRowAction(event) {
    //     const action = event.detail.action;
    //     const row = event.detail.row;
    //     if (action.name === 'edit') {
    //         this.toggleEditMode();
    //     } else if (action.name === 'delete') {
    //         // Implement logic to delete the selected record
    //         // For example, splice the record from this.contacts
    //     }
    // }

    toggleEditMode() {
        this.isEditMode = !this.isEditMode;
    }

    async handleSave(event) {
        const updatedFields = event.detail.draftValues;
    
        // Prepare the record IDs for notifyRecordUpdateAvailable()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
    
        try {
            // Pass edited fields to the updateContacts Apex controller
            const result = await updateContacts({data: updatedFields});
            console.log(JSON.stringify("Apex update result: "+ result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
    
            // Refresh LDS cache and wires
            notifyRecordUpdateAvailable(notifyChangeIds);
    
            // Display fresh data in the datatable
            await refreshApex(this.contacts);
                // Clear all draft values in the datatable
                this.draftValues = [];
        } catch(error) {
               this.dispatchEvent(
                   new ShowToastEvent({
                       title: 'Error updating or refreshing records',
                       message: error.body.message,
                       variant: 'error'
                   })
             );
        };
    }

    @wire(getAllAccounts)
    accountsHandler({data, error}) {
        if(data) {
            this.accounts = this.getAccountOptions(data);
        }
        if(error) {
            console.error(error);
        }
    }

    getAccountOptions(data) {
        return data.map(item => ({
            label: item.Name,
            value: item.Id
        }));
    }

    selectedAccount;

    handleAccountChange(event) {
        this.selectedAccount = event.target.value;
        getContacts({accId: this.selectedAccount})
            .then(data => {
                this.contacts = data;
                console.log(JSON.stringify(this.contacts));
            })
            .catch(error => {
                console.error(error);
            })
    }
}