import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import Name from '@salesforce/schema/Account.Name';
import Type from '@salesforce/schema/Account.Type';
import Industry from '@salesforce/schema/Account.Industry';
import AnnualRevenue from '@salesforce/schema/Account.AnnualRevenue';
import Rating from '@salesforce/schema/Account.Rating';
import Website from '@salesforce/schema/Account.Website';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class RecordFormAccount extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    recordId = '0015h00001SybD1AAJ';
    fields = [Name, Type, Industry, AnnualRevenue, Rating, Website];

    successHandler() {
        const toast = new ShowToastEvent({
            title: 'Success',
            message: 'Account record has been saved successfully!',
            variant: 'success'
        });
        this.dispatchEvent(toast);
    }
}