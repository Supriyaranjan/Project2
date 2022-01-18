import { LightningElement, wire, track } from 'lwc';
import getContactInfo from '@salesforce/apex/ContactController.getContactInfo';

export default class ProfileTestComp extends LightningElement {
    @wire(getContactInfo) contacts;
    @track myRecordId = [];

    connectedCallback() {
        getContactInfo()
        .then((result) => {
            this.myRecordId = result.Id;
        })
    }
}