import Id from '@salesforce/user/Id';
import { LightningElement, api } from 'lwc';

export default class OrderPage extends LightningElement {
    @api order;
    userId = Id;
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
    }
    

}