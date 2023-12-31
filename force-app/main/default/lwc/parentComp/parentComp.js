import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    showHandler1(event){
        console.log('Parent Comp: c-child-comp');
        console.log(event.target.nodeName);
        console.log(event.currentTarget.nodeName);
    }
    showHandler2(event){
        console.log('Parent Comp: div');
        console.log(event.target.nodeName);
        console.log(event.currentTarget.nodeName);
    }
}