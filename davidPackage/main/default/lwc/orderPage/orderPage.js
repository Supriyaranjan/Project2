import createOrder from '@salesforce/apex/orderPageController.createOrder';
import createOrderItems from '@salesforce/apex/orderPageController.createOrderItems';
import Id from '@salesforce/user/Id';
import { LightningElement, api } from 'lwc';

export default class OrderPage extends LightningElement {
    @api order;
    @api useridfromsupriya;
    contactId = '';
    message = 'Hello from order';
    displayOrder = true;
    showTotal = false;
    finalize = false;
    total = 0;

    testId = Id;

    product2Ids = [];
    quantities = [];
    unitPrices = [];

    orderTotal(){
        this.total = 0;
        this.showTotal = !this.showTotal;
        for(let i = 0; i < this.order.length; i++){
            this.total += (this.order[i].price * this.order[i].quantity);
        }//end for i
        console.log('Here is the message ' + this.useridfromsupriya);
    }//end orderTotal

    confirmOrder(){
        createOrder({userId: this.useridfromsupriya})
        .then(result =>{
            console.log('Order Confirmed ' + result);
            this.contactId = result;
            this.showTotal = false;
            this.finalize = true;
        })
        .catch(error =>{
            console.error(error);
        })
        
        for(let i = 0; i < this.order.length; i++){
            this.product2Ids.push(this.order[i].id);
            this.quantities.push(this.order[i].quantity);
            this.unitPrices.push(this.order[i].price);

            console.log('These are the list sizes in Js ' + this.product2Ids[i] + ' ' + this.quantities[i] + ' ' + this.unitPrices[i]);

        }//end for i
    }//end confirmOrder

    placeOrder(){
        createOrderItems({contactId: this.contactId, product2Ids: this.product2Ids, quantities: this.quantities, unitPrices: this.unitPrices, totalItems: this.product2Ids.length})
        .then(result=>{
            console.log('Order was success: ');
        })
        .error(error=>{
            console.error(error);
        })

    }//end placeOrder
    

}