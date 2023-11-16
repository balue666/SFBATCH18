import { LightningElement } from 'lwc';

export default class TemplateLooping3 extends LightningElement {
    products = [
        {
            Id: '1',
            ProductName: 'iPhone 15',
            Cost: 2000,
            Category: 'Smartphone'
        },
        {
            Id: '2',
            ProductName: 'iPad 10',
            Cost: 1500,
            Category: 'Tablet'
        },
        {
            Id: '3',
            ProductName: 'MacBook',
            Cost: 5000,
            Category: 'Laptop'
        },
        {
            Id: '4',
            ProductName: 'iPods',
            Cost: 1000,
            Category: 'Earpods'
        }
    ];
}