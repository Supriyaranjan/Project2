import { LightningElement, wire } from 'lwc';
import getContactInfo from '@salesforce/apex/ContactController.getContactInfo';

export default class TrialProfile extends LightningElement {
    @wire(getContactInfo) contacts;
}