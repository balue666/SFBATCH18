import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import getAccountsByIndustry from '@salesforce/apex/AccountCtrl.getAccountsByIndustry';

const COLUMNS = [
    {label: 'Account Name', fieldName: 'Name', type: 'text'},
    {label: 'Account Type', fieldName: 'Type', type: 'text'},
    {label: 'Industry', fieldName: 'Industry', type: 'text'},
    {label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency'}
];

export default class ImperativeApex2 extends LightningElement {
    industryOptions;
    selectedIndustry;
    records;
    messages = 'Please select an industry in order to see the matching accounts';
    columns = COLUMNS;

    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    accInfo;

    @wire(getPicklistValues, {
        fieldApiName: INDUSTRY_FIELD,
        recordTypeId: '$accInfo.data.defaultRecordTypeId'
    }) picklistHandler({data, error}){
        if(data){
            this.industryOptions = data.values;
        }
        if(error){
            console.error(error);
        }
    }

    changeHandler(event){
        this.selectedIndustry = event.target.value;
        getAccountsByIndustry({industry: this.selectedIndustry})
            .then(result => {
                if(result.length > 0){ //at least one record
                    this.records = result;
                    this.messages = undefined;
                } else { // no records
                    this.messages = 'There are no maching accounts under ' + this.selectedIndustry;
                    this.records = undefined;
                }
            })
            .catch(error => {
                this.messages = 'Error occurred while fetching the matching account records';
                this.records = undefined;
            })
    }
}