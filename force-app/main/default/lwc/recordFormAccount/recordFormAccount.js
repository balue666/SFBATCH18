import { api, LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import Name from '@salesforce/schema/Account.Name';
import Type from '@salesforce/schema/Account.Type';
import Industry from '@salesforce/schema/Account.Industry';
import AnnualRevenue from '@salesforce/schema/Account.AnnualRevenue';
import Rating from '@salesforce/schema/Account.Rating';
import Website from '@salesforce/schema/Account.Website';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import USER_ID from '@salesforce/user/Id';

export default class RecordFormAccount extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    @api recordId // = '0015h00001SybD1AAJ';
    fields = [Name, Type, Industry, AnnualRevenue, Rating, Website];
    userId = USER_ID;

    successHandler() {
        const toast = new ShowToastEvent({
            title: 'Success',
            message: 'Account record has been saved successfully!',
            variant: 'success'
        });
        this.dispatchEvent(toast);
    }
}