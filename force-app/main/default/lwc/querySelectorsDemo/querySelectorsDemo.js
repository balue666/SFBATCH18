import { LightningElement } from 'lwc';

export default class QuerySelectorsDemo extends LightningElement {

    fruits = ['Apple', 'Banana', 'Strawberry', 'Orange'];

    clickHandler(){
        //querySelector demo
        const h1elem = this.template.querySelector('h1');
        console.log(h1elem.innerText);
        h1elem.style.color = 'green';
        h1elem.style.border = '2px solid red';
        h1elem.style.background = 'yellow';
        h1elem.style.fontSize = '18px';

        //querySelectors demo
        const divelems = this.template.querySelectorAll('div.child');
        divelems.forEach(item => {
            console.log(item.innerText);
            item.style.color = 'green';
            item.style.border = '2px solid yellow';
            item.setAttribute('class', 'slds-align_absolute-center');
        })
    }
}