import { LightningElement, wire } from 'lwc';
import TITLE_FIELD from '@salesforce/schema/Ecommerce_Product__c.Name';
import PROD_ID_FIELD from '@salesforce/schema/Ecommerce_Product__c.Product_Id__c';
import BRAND_FIELD from '@salesforce/schema/Ecommerce_Product__c.Brand__c';
import CATEGORY_FIELD from '@salesforce/schema/Ecommerce_Product__c.Category__c';
import PRICE_FIELD from '@salesforce/schema/Ecommerce_Product__c.Price__c';
import DESC_FIELD from '@salesforce/schema/Ecommerce_Product__c.Description__c';
import { getFieldDisplayValue, getFieldValue, getRecord } from 'lightning/uiRecordApi';

const FIELDS = [TITLE_FIELD, PROD_ID_FIELD, BRAND_FIELD, CATEGORY_FIELD, PRICE_FIELD, DESC_FIELD];

export default class GetRecordProduct extends LightningElement {
    recordId = 'a035h00000eVH1yAAG';
    title;
    prodId;
    brand;
    category;
    price;
    desc;

    @wire(getRecord, {recordId: '$recordId', fields: FIELDS})
    recordHandler({data, error}) {
        if(data) {
            console.log(data);
            //Approach 1
            this.title = data.fields.Name.value;
            this.prodId = data.fields.Product_Id__c.value; 
            this.brand = data.fields.Brand__c.value;
            this.category = data.fields.Category__c.value;
            this.price = data.fields.Price__c.displayValue;
            this.desc = data.fields.Description__c.value;

            //Approach 2
            this.title = getFieldValue(data, TITLE_FIELD);
            this.price = getFieldDisplayValue(data, PRICE_FIELD);
        }
        if(error) {
            console.error(error);
        }
    }
}