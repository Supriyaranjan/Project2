import { LightningElement, track } from 'lwc';

export default class Fetchcarimage extends LightningElement {

    @track
    carText;

    displayImage = false;

    carImageUrl = "";

    responseData = "";

    carTextChange(event)
    {
        this.carText = event.target.value;
    }

    //function to get the car image
    getCarImage()
    {
        let imageTarget = "https://www.carimagery.com/api.asmx/GetImageUrl?searchTerm=" + this.carText;

        fetch(imageTarget)
        .then(response => {
            console.log("Response code for API call: " + response.status);
            if (response.status >= 200 && response.status <= 299) 
            {
              return response.text();
            }

            throw Error(response.statusText);
          })
          .then(apiData => {
            console.log(apiData);
            this.responseData = apiData;
            let doc = new window.DOMParser().parseFromString(this.responseData, "text/xml");
            console.log(doc.documentElement.textContent);
            this.carImageUrl = doc.documentElement.textContent;
            this.displayImage = true;
        })
        .catch(error => {
            console.error("Request resulted in an error: " + error);
        })

    }
}