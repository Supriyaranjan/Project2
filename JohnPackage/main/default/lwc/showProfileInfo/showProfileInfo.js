import { LightningElement, wire, api } from 'lwc';
import getContactInfo from '@salesforce/apex/ContactController.getContactInfo';

export default class ShowProfileInfo extends LightningElement {
    @api recordId;
    @wire(getContactInfo) contacts;
    


}