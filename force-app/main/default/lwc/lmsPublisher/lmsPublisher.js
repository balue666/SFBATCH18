import { MessageContext, publish } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import SI_CHANNEL from '@salesforce/messageChannel/SoftInnovas__c';

export default class LmsPublisher extends LightningElement {
    msg;

    changeHandler(event){
        this.msg = event.target.value;
    }

    @wire(MessageContext)
    context;

    publishHandler(){
        //prepare message
        const message = {
            lmsData: this.msg
        }
        publish(
            this.context,
            SI_CHANNEL,
            message
        );
        console.log('message published');
    }
}