import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import { LightningElement, track, wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpdateRecordAccount extends LightningElement {
    accountId = '0015h00001SybD1AAJ';
    acc;
    typeOptions;
    industryOptions;
    @track formdata = {};

    //get the account record detail
    @wire(getRecord, {
        recordId: '$accountId',
        layoutTypes: ['Full'],
        modes: ['View']
    }) recordHandler({data, error}) {
        if(data) {
            console.log(data);
            this.acc = data;
        }
        if(error) {
            console.error(error);
        }
    }

    //get the picklist values of Type & Industry
    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    accountInfo;

    @wire(getPicklistValuesByRecordType, {
        objectApiName: ACCOUNT_OBJECT,
        recordTypeId: '$accountInfo.data.defaultRecordTypeId'
    }) picklistHandler({data, error}) {
        if(data){
            this.typeOptions = data.picklistFieldValues.Type.values;
            this.industryOptions = data.picklistFieldValues.Industry.values;
        }
        if(error){
            console.error(error);
        }
    }

    changeHandler(event) {
        const name = event.target.name;
        const value = event.target.value;
        this.formdata[name] = value;
    }

    recordUpdateHandler() {
        //prepare recordInput
        const name = 'Id';
        const value = this.accountId;
        this.formdata[name] = value;

        const recordInput = {
            fields:this.formdata
        };

        //update record
        updateRecord(recordInput)
            .then(result => {
                const toast = new ShowToastEvent({
                    title: 'Record updated successfully',
                    variant: 'success'
                });
                this.dispatchEvent(toast);
            })
            .catch(error => {
                console.error(error);
            })
    }
}