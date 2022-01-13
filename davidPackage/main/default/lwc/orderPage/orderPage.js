import getAccountId from '@salesforce/apex/orderPageController.findAccount';
import Id from '@salesforce/user/Id';
import { LightningElement, api } from 'lwc';

export default class OrderPage extends LightningElement {
    @api order;
    user = '';
    message = 'Hello from order';
    displayOrder = true;
    showTotal = false;
    total = 0;
    orderTotal(){
        this.total = 0;
        this.showTotal = !this.showTotal;
        for(let i = 0; i < this.order.length; i++){
            this.total += (this.order[i].price * this.order[i].quantity);
        }//end for i
    }//end orderTotal

    confirmOrder(){
        getAccountId({userId: Id})
        .then(result =>{
            console.log('Order Confirmed ' + result);
        })
        .catch(error =>{
            console.error(error);
        })
        
    }//end confirmOrder
    

}