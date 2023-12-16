import { LightningElement } from 'lwc';

export default class ProgressParent extends LightningElement {

    size;
    value;

    get progressOptions(){
        return [
            {label: 'small', value: 'small'},
            {label: 'medium', value: 'medium'},
            {label: 'large', value: 'large'}
        ];
    }

    changeHandler(event){
        if(event.target.name === 'Progress Size'){
            this.size = event.target.value;
        } else {
            this.value = event.target.value;
        }
    }
}