import { LightningElement, wire } from 'lwc';
import getContactInfo from '@salesforce/apex/ContactController.getContactInfo';

export default class DisplayProfileInfo extends LightningElement {
    @wire(getContactInfo) contacts;

}