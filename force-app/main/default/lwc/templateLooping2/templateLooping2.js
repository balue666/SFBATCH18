import { LightningElement } from 'lwc';

export default class TemplateLooping2 extends LightningElement {
    opps = [
        {
            Id: '1',
            AccountName: 'Edge Communications',
            Amount: 10000000,
            StageName: 'Prospecting',
            Type: 'New Customer'
        },
        {
            Id: '2',
            AccountName: 'Universal Containers',
            Amount: 20000000,
            StageName: 'Needs Analysis',
            Type: 'Existing Customer - Upgrade'
        },
        {
            Id: '3',
            AccountName: 'Soft Innovas',
            Amount: 30000000,
            StageName: 'Closed Won',
            Type: 'Existing Customer'
        }
    ];
}