

import { LightningElement, track, api } from 'lwc';
import getProducts from '@salesforce/apex/productPageController.getProducts';
import {pics} from 'c/productPhotos'; 


export default class ProductPage extends LightningElement {

    @track pData = [];
    cart = [];
    showProducts = false;
    showProductButton = true;
    showOrder = false;
    productIndex = 0;

    displayProducts(){
        this.showProducts = true;
        this.showProductButton = false;
        this.showOrder = false;
        getProducts()
        .then(products =>{
            if(this.pData.length == 0){
            for(let i = 0; i < products.length; i++){
                for(let j = 0; j < pics.length; j++){
                    if(products[i].Name == pics[j].name){
                        this.pData.push({id: products[i].Id, Name: products[i].Name, Description: products[i].Description, image: pics[j].image, quantity: 0, index: this.productIndex, price: products[i].PricebookEntries[0].UnitPrice, total: 0});
                        this.productIndex++;
                        console.log('We are in the products function' + products[i].Name);
                    }
                }
            }
            console.log('We got the products, boys');
            }   
            })
             .catch(error=>{
                console.error(error);
            })
        
    }

    goBack(){
        this.showProducts = true;
        this.showOrder = false;
        this.cart = [];
    }

    increaseQuant(event){
        console.log('Increase Quantity of ' + event.target.value.Name);
        this.pData[event.target.value.index].quantity++;
        this.pData[event.target.value.index].total = this.pData[event.target.value.index].quantity * this.pData[event.target.value.index].price;

    }

    decreaseQuant(event){
        console.log('Decrease Quantity of ' + event.target.value.Name);
        if(this.pData[event.target.value.index].quantity > 0){
            this.pData[event.target.value.index].quantity--;
            this.pData[event.target.value.index].total = this.pData[event.target.value.index].quantity * this.pData[event.target.value.index].price;

        }
        
    }

    displayOrder(){
        this.showProducts = false;
        this.showOrder = !this.showOrder;
        for(let i = 0; i < this.pData.length; i++){
            if(this.pData[i].quantity > 0){
                this.cart.push(this.pData[i]);
            }//end if
        }//end for i
    }

}