import { LightningElement, wire } from 'lwc';
import getTopAccounts from '@salesforce/apex/AccountCtrl.getTopAccounts';

export default class WiredApex1 extends LightningElement {
    accounts;
    errors;

    @wire(getTopAccounts)
    accountHandler({data, error}) {
        if(data) {
            this.accounts = data;
        }
        if(error) {
            console.error(error);
            this.errors = error;
        }
    }
}