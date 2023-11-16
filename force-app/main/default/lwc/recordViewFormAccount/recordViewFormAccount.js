import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class RecordViewFormAccount extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    recordId = '0015h00001SybD1AAJ';
    fields = {
        name: NAME_FIELD,
        type: TYPE_FIELD,
        industry: INDUSTRY_FIELD,
        revenue: REVENUE_FIELD,
        rating: RATING_FIELD,
        website: WEBSITE_FIELD
    };
}