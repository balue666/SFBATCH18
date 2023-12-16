import { LightningElement } from 'lwc';
import searchContacts from '@salesforce/apex/ContactCtrl.searchContacts';

const COLUMNS = [
    {label: 'First Name', fieldName: 'FirstName', type: 'text'},
    {label: 'Last Name', fieldName: 'LastName', type: 'text'},
    {label: 'Title', fieldName: 'Title', type: 'text'},
    {label: 'Department', fieldName: 'Department', type: 'text'}
];

export default class ContactSearch extends LightningElement {
    searchWord;
    contacts;
    errors = 'Enter some key words in order to find matching contacts';
    columns = COLUMNS;

    changeHandler(event){
        this.searchWord = event.target.value;

        //make apex call
        searchContacts({searchKey: this.searchWord})
            .then(result => {
                if(result.length > 0){
                    this.contacts = result;
                    this.errors = undefined;
                } else {
                    this.contacts = undefined;
                    this.errors = 'There are no matching contacts!';
                }
            })
            .catch(error => {
                this.contacts = undefined;
                this.errors = 'Error occurred';
            })
    }
}