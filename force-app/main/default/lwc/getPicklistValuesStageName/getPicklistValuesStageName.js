import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import OPP_OBJECT from '@salesforce/schema/Opportunity';

export default class GetPicklistValuesStageName extends LightningElement {

    oppRtId;
    stageOptions;
    selectedStage;

    @wire(getObjectInfo, {objectApiName: OPP_OBJECT})
    oppRtDetails;

    @wire(getPicklistValues, {fieldApiName: STAGE_FIELD, recordTypeId: '$oppRtDetails.data.defaultRecordTypeId'})
    picklistHandler({data, error}) {
        if(data) {
            console.log(data);
            this.stageOptions = data.values;
        }
        if(error) {
            console.error(error);
        }
    }

    changeHandler(event) {
        this.selectedStage = event.target.value;
    }
}