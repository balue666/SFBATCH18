import { LightningElement, wire } from 'lwc';
import getOppsByStage from '@salesforce/apex/OpportunityCtrl.getOppsByStage';

const COLUMNS = [
    {label: 'Opp Name', fieldName: 'Name', type: 'text'},
    {label: 'Type', fieldName: 'Type', type: 'text'},
    {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
    {label: 'Amount', fieldName: 'Amount', type: 'currency'},
    {label: 'Close Date', fieldName: 'CloseDate', type: 'date'}
];

export default class WiredApex2 extends LightningElement {
    targetStage = 'Closed Won';
    opps;
    errors;
    columns = COLUMNS;

    @wire(getOppsByStage, {stage: '$targetStage'})
    oppsHandler({data, error}){
        if(data){
            this.opps = data;
        }
        if(error){
            this.errors = error;
        }
    }
}