import { LightningElement } from 'lwc';

export default class ModalParent extends LightningElement {
    showModal = false;
    msg;

    modalHandler(){
        this.showModal = true;
    }

    closeHandler(event){
        //console.log(event.detail);
        this.msg = event.detail;
        this.showModal = false;
    }
}