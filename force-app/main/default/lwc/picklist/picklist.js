import { LightningElement } from 'lwc';

export default class Picklist extends LightningElement {
    selectedCountry;

    changeHandler(event) {
        this.selectedCountry = event.target.value;
    }

    get options() {
        return [
            {label: 'United States', value: 'United States'},
            {label: 'Turkiye', value: 'Turkiye'},
            {label: 'India', value: 'India'}
        ];
    }
}