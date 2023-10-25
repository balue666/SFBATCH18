import { LightningElement, track, wire } from 'lwc';
import getAllPets from '@salesforce/apex/PetCtrl.getAllPets';

export default class PetDashboard extends LightningElement {
    @track pets;

    @wire(getAllPets)
    petHandler({data, error}) {
        if(data) {
            this.pets = data;
        }
        if(error) {
            console.error(error);
        }
    }
}