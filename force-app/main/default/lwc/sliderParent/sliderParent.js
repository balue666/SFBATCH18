import { LightningElement } from 'lwc';

export default class SliderParent extends LightningElement {
    volume;

    changeHandler(event){
        this.volume = event.target.value;
    }

    resetHandler(){
        this.template.querySelector('c-slider-child').resetSlider();
    }
}