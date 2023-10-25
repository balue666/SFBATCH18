import { api, LightningElement } from 'lwc';
import getRecipeDetails from '@salesforce/apex/SpoonacularCallouts.getRecipeDetails';
export default class Recipe extends LightningElement {
    @api recipeId;
    @api recipeImage;
    @api title;
    @api summary;
    @api pricePerServing;
    @api readyInMinutes;
    @api dishTypes;
    @api diets;

    get showDetails() {
        if(this.summary || this.pricePerServing) {
            return true;
        }
        return false;
    }

    getDetails() {
        getRecipeDetails({recipeId: this.recipeId})
            .then(result => {
                const recipe = JSON.parse(result);
                this.summary = recipe.summary;
                this.pricePerServing = recipe.pricePerServing;
                this.readyInMinutes = recipe.readyInMinutes;
                this.dishTypes = recipe.dishTypes;
                this.diets = recipe.diets;
            })
            .catch(error => {
                console.error(error);
            })
    }
}