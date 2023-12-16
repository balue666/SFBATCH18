import { LightningElement } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountCtrl.getAllAccounts';

const COLUMNS = [
    {label: 'Account Name', fieldName: 'Name', type: 'text'},
    {label: 'Account Type', fieldName: 'Type', type: 'text'},
    {label: 'Industry', fieldName: 'Industry', type: 'text'},
    {label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'text'}
];

export default class AccountControls extends LightningElement {
    showAllAccounts = false;
    showTotalRevenue = false;
    showHighestRevenue = false;
    accounts;
    columns = COLUMNS;
    totalRevenue;
    highestRevenue;

    fetchAllAccounts(){
        this.showAllAccounts = true;
        this.showTotalRevenue = false;
        this.showHighestRevenue = false;

        //call apex
        getAllAccounts()
            .then(result => {
                this.accounts = result;
            })
            .catch(error => {
                console.error(error);
            })
    }

    fetchTotalRevenue(){
        this.showTotalRevenue = true;
        this.showAllAccounts = false;
        this.showHighestRevenue = false;

        //calculate totals
        if(this.accounts){
            let total = 0;
            this.accounts.forEach(acc => {
                total = total + acc.AnnualRevenue;
            });
            this.totalRevenue = total;
        }
    }

    fetchHighestRevenue(){
        this.showHighestRevenue = true;
        this.showAllAccounts = false;
        this.showTotalRevenue = false;

        //calculate the highest
        if(this.accounts){
            let highest = 0;
            this.accounts.forEach(acc => {
                if(acc.AnnualRevenue > highest) {
                    highest = acc.AnnualRevenue;
                }
            });
            this.highestRevenue = highest;
        }
    }
}