import { LightningElement, track } from 'lwc';
import GetFAQByTopic from '@salesforce/apex/CaseWebController.GetFAQByTopic'
import GetFAQTopic from '@salesforce/apex/CaseWebController.GetFAQTopic'

export default class Searchfaq extends LightningElement {

    @track
    mySearchedFAQs = [];

    @track
    faqTopic;

    @track
    myTopics = [];

    connectedCallback()
    {
        this.myTopics = [];
        GetFAQTopic()
        .then((result) => {
            this.myTopics = result;
            this.faqTopic = this.myTopics[0];
        })
        .catch((error) => {
            console.log(error);
            this.myTopics = [];
        });
    }

    faqTopicChange(event)
    {
        this.faqTopic = event.target.value;
    }

    //get courselist for the entered text
    getFAQsByTopic()
    {
        this.mySearchedFAQs = [];
        GetFAQByTopic({topicName: this.faqTopic})
        .then((result) => {
            this.mySearchedFAQs = result;
            //dispatch a custom event after faq result search
            this.dispatchEvent(new CustomEvent('faqresult', { detail: { faq:this.mySearchedFAQs, }, }));
        })
        .catch((error) => {
            console.log(error);
            this.mySearchedFAQs = [];
            this.dispatchEvent(new CustomEvent('faqresult', { detail: { faq:this.mySearchedFAQs, }, }));
        });
    }
    
}