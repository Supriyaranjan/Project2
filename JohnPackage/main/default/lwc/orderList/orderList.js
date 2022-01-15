import { LightningElement, wire } from 'lwc';
import getOrderList from '@salesforce/apex/OrderController.getOrderList';

export default class OrderList extends LightningElement {
   @wire(getOrderList) orders; 

}
