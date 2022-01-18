import { LightningElement, wire } from 'lwc';
import getOrderList from '@salesforce/apex/OrderController.getOrderList';

export default class OrderList extends LightningElement {
   @wire(getOrderList) orders; 

   handleSelect(event) {
      
      event.preventDefault();
      
      const selectEvent = new CustomEvent('orderselect', {
          detail: { orderId: event.currentTarget.dataset.orderId }
      });
      
      this.dispatchEvent(selectEvent);
  }
}
