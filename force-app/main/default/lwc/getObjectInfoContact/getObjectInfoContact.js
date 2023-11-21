import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class GetObjectInfoContact extends LightningElement {

    defaultRtId;
    customerRtId;

    @wire(getObjectInfo, {objectApiName: CONTACT_OBJECT})
    contactInfoHandler({data, error}) {
        if(data) {
            console.log(data);
            this.defaultRtId = data.defaultRecordTypeId;
            const rtids = data.recordTypeInfos;
            this.customerRtId = Object.keys(rtids).find(rtid => rtids[rtid].name === 'Customer Contact');
        }
        if(error) {
            console.error(error);
        }
    }
}