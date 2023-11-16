import { LightningElement } from 'lwc';

export default class Getters extends LightningElement {
    num1 = 10;
    num2 = 20;

    fruits = ['Banana', 'Apple', 'Grape', 'Pomogranate'];

    get firstFruit() {
        return this.fruits[0];
    }

    get product() {
        return this.num1 * this.num2;
    }
}