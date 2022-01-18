import { LightningElement } from 'lwc';
import saveFutureCustomProduct from "@salesforce/apex/FutureProductController.saveFutureCustomProduct";

export default class FutureProductProposal extends LightningElement {
    displayNotification = true;
    displayNameError = true;
    displayDescriptionError = true;
    handleProposalSubmit() {
        //Get proposal name
        let nameInput = this.template.querySelector("input[type=text]");
        let newProposalName = nameInput.value;

        //If length less than 4, warn notification
        if(newProposalName.length < 4) {
            this.displayNameError = false;    
            let textToDisplay = this.template.querySelector(".nameErrorNotificationText");
            textToDisplay.value = "Name length should not less than 4 characters";

            //The notification text dsiplay 5 seconds 
            setTimeout(() => {
                this.displayNameError = true;
            }, 5000);
            return;
        }

        //Get proposal description
        let descriptionInput = this.template.querySelector("textarea");
        let newProposalDescription = descriptionInput.value;

        //If length less than 10, warn notification
        if(newProposalDescription.length < 10) {
            this.displayDescriptionError = false;    
            let textToDisplay = this.template.querySelector(".descriptionErrorNotificationText");
            textToDisplay.value = "Description length should not less than 10 characters";

            //The notification text dsiplay 5 seconds 
            setTimeout(() => {
                this.displayDescriptionError = true;
            }, 5000);
            return;
        }

        let newProductProposal ={
            Name: newProposalName,
            Description: newProposalDescription,
            DisplayUrl: "",
            ProductCode: ""

        };
        console.log(newProductProposal);

        //Save proposal record to Database
        saveFutureCustomProduct({newProduct:newProductProposal}).then((result) => {
            console.log("Save successful");
            console.log(result);
        }).catch((error) => {
            console.log(error);
        });

        nameInput.value = '';
        descriptionInput.value = '';

        this.displayNotification = false;    
        let textToDisplay = this.template.querySelector(".proposalNotificationText");
        //console.log(textToDisplay);
        textToDisplay.value = "Your proposal submitted, thank you! ";
        
        //The notification text dsiplay 10 seconds 
        setTimeout(() => {
            this.displayNotification = true;
        }, 10000);
    }
}