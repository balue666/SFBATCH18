import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { LightningElement, track, wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateRecordAccount extends LightningElement {
    typeOptions;
    industryOptions;
    @track formdata = {};

    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    accountInfo;

    @wire(getPicklistValuesByRecordType, {
        objectApiName: ACCOUNT_OBJECT,
        recordTypeId: '$accountInfo.data.defaultRecordTypeId'
    }) picklistHandler({data, error}) {
        if(data) {
            this.typeOptions = data.picklistFieldValues.Type.values;
            this.industryOptions = data.picklistFieldValues.Industry.values;
        }
        if(error) {
            console.error(error);
        }
    }

    changeHandler(event) {
        const name = event.target.name;
        const value = event.target.value;
        this.formdata[name] = value;
        console.log(this.formdata);
        console.log(JSON.stringify(this.formdata));
    }

    cancelHandler() {
        this.template.querySelector('form.accountform').reset();
    }

    createHandler() {
        //prepare recordInput
        const recordInput = {
            apiName: ACCOUNT_OBJECT.objectApiName,
            fields: this.formdata
        }

        createRecord(recordInput)
            .then(result => {
                //show success message
                this.prepareToast('Success', 'success');
            })
            .catch(error => {
                //show error message
                console.error(error);
                this.prepareToast('Failure', 'error');
            })
    }

    prepareToast(title, variant) {
        const toast = new ShowToastEvent({
            title: title,
            variant: variant
        });
        this.dispatchEvent(toast);
    }
}