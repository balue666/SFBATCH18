import { LightningElement, track } from 'lwc';
import getRandomRecipe from '@salesforce/apex/SpoonacularCallouts.getRandomRecipe';
import searchRecipeByIngredients from '@salesforce/apex/SpoonacularCallouts.searchRecipeByIngredients';

export default class RecipeSearch extends LightningElement {

    searchWord;
    @track recipes;

    //grab the entered ingr
    changeHandler(event) {
        this.searchWord = event.target.value;
    }

    //search for recipes based on ingr
    searchHandler() {
        searchRecipeByIngredients({ingr: this.searchWord})
            .then(result => {
                console.log(result);
                this.recipes = JSON.parse(result);
            })
            .catch(error => {
                console.error(error);
            })
    }

    //Get a random recipe
    randomRecipeHandler() {
        getRandomRecipe()
            .then(result => {
                console.log(result);
                this.recipes = JSON.parse(result).recipes;
            })
            .catch(error => {
                console.error(error);
            })
    }
}