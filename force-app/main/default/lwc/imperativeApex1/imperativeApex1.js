import { LightningElement } from 'lwc';
import getAllOpps from '@salesforce/apex/OpportunityCtrl.getAllOpps';

const COLUMNS = [
    {label: 'Opp Name', fieldName: 'Name', type: 'text'},
    {label: 'Type', fieldName: 'Type', type: 'text'},
    {label: 'Stage', fieldName: 'StageName', type: 'text'},
    {label: 'Close Date', fieldName: 'CloseDate', type: 'date'},
    {label: 'Amount', fieldName: 'Amount', type: 'currency'}
];

export default class ImperativeApex1 extends LightningElement {
    showAllOppsSection = false;
    showAmountSection = false;
    opps;
    columns = COLUMNS;
    totalAmount;

    showAllOppsHandler(){
        this.showAllOppsSection = true;
        this.showAmountSection = false;

        //call apex & get all opps
        getAllOpps()
            .then(result => {
                this.opps = result;
            })
            .catch(error => {
                console.error(error);
            })
    }

    showAmountHandler(){
        this.showAmountSection = true;
        this.showAllOppsSection = false;

        //calculate the sum
        if(this.opps){
            let total = 0;
            this.opps.forEach(opp => {
                total = total + opp.Amount;
            })
            this.totalAmount = total;
        }
    }
}