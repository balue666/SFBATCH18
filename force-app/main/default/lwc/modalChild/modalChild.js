import { LightningElement } from 'lwc';

export default class ModalChild extends LightningElement {
    
    clickHandler(){
        //const data = 'Child close button was clicked';
        const data = 'https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_1280.jpg';
        const evt = new CustomEvent('close', {detail: data});
        this.dispatchEvent(evt);
    }
}