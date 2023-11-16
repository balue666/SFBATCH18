import { LightningElement } from 'lwc';

export default class ConditionalRendering2 extends LightningElement {
    showData = false;

    clickHandler() {
       //this.showData = true; 
       this.showData = !this.showData;
    }
}