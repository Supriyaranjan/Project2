import { LightningElement, api } from 'lwc';

import Reason from '@salesforce/schema/Case.Reason';
import Subject from '@salesforce/schema/Case.Subject';
import CaseSource from '@salesforce/schema/Case.Origin'
import Type from '@salesforce/schema/Case.Type';
import Description from '@salesforce/schema/Case.Description';

export default class Webtocase extends LightningElement {

    @api
    caseDescription = Description;

    @api
    caseType = Type;

    @api
    caseReason = Reason;

    @api
    caseSubject = Subject;

    @api
    caseOriginSource = CaseSource;

    displayForm = true;
    
    displayResponseMessage = "";

    caseId;

    handleSuccess(event){
        this.displayForm = false;
        this.caseId = event.detail.id;
        console.log(event.detail);
        this.displayResponseMessage = "Thanks for contacting us. We will get back to you shortly";

    }

    handleError(){
        this.template.querySelector('[data-id="formerror"]').setError('Fail to create Case');
    }
}