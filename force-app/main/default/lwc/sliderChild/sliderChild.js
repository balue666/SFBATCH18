import { api, LightningElement } from 'lwc';

export default class SliderChild extends LightningElement {
    @api sliderValue;

    @api resetSlider(){
        this.sliderValue = 50;
    }
}