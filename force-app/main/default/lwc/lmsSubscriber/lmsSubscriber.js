import { APPLICATION_SCOPE, MessageContext, subscribe } from 'lightning/messageService';
import { LightningElement, wire } from 'lwc';
import SI_CHANNEL from '@salesforce/messageChannel/SoftInnovas__c';

export default class LmsSubscriber extends LightningElement {
    receivedMsg;

    connectedCallback(){
        this.subscribeToChannel();
    }

    @wire(MessageContext)
    context;

    subscribeToChannel(){
        subscribe(
            this.context,
            SI_CHANNEL,
            (message) => { this.subscribeHandler(message) },
            { scope: APPLICATION_SCOPE }
        );
    }

    subscribeHandler(message){
        this.receivedMsg = message.lmsData;
    }
}