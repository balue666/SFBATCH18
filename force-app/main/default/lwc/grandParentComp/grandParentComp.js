import { LightningElement } from 'lwc';

export default class GrandParentComp extends LightningElement {
    showHandler1(event){
        console.log('Grand Parent Comp: c-parent-comp');
        console.log(event.target.nodeName);
        console.log(event.currentTarget.nodeName);
    }
}