import { api, LightningElement } from 'lwc';

export default class ProgressChild extends LightningElement {
    @api progSize;
    @api progValue;
}