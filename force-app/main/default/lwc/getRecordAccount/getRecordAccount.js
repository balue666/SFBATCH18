import { getRecord } from 'lightning/uiRecordApi';
import { LightningElement, wire } from 'lwc';

export default class GetRecordAccount extends LightningElement {

    recordId = '0015h00001SybD1AAJ';
    account;

    @wire(getRecord, {recordId: '$recordId', layoutTypes: ['Full'], modes: ['View']})
    recordHandler({data, error}) {
        if(data) {
            this.account = data;
        }
        if(error) {
            console.error(error);
        }
    }
}