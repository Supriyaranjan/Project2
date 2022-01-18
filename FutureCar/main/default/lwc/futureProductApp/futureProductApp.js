import { LightningElement,api, track } from 'lwc';
import Future_Car from '@salesforce/resourceUrl/FutureCar';
import getFutureProducts from "@salesforce/apex/FutureProductController.getFutureProducts";
import saveFutureProduct from "@salesforce/apex/FutureProductController.saveFutureProduct";

export default class FutureProductApp extends LightningElement {

    @api
    futureCars;

    @track
    displayCars = [];

    @track
    displayIndex = 0;
    

    constructor() {
        super();
        /*getFutureProducts().then(result => {
            this.futureCars = result;
            console.log(result.length);
            if(result.length < 3) {
                let futureCars= [{Name: "FutureElCar2",
                    Description: "Electric car",
                    DisplayUrl: "/Electric/2.jpg",
                    ProductCode: "0022028"},
                    {Name: "FutureSportCar3",
                    Description: "Sport car",
                    DisplayUrl: "/sports/3.jpg",
                    ProductCode: "0022027"},
                    {Name: "FutureLuxuryCar5",
                    Description: "Luxury car",
                    DisplayUrl: "/Luxury/5.jpg",
                    ProductCode: "0022029"}
                ];
                console.log(futureCars);
                for(let i = 0; i < 3; i++) {
                    saveFutureProduct(futureCars[i]);
                }
            }
        }).catch((error) => {
            console.log(error);
        });*/
    }
    //Get data from database when initialize
    connectedCallback() {
        getFutureProducts().then(result => {
            this.futureCars = result;
            for(let i=0; i < this.futureCars.length; i++) {
                this.futureCars[i].DisplayUrl = Future_Car + this.futureCars[i].DisplayUrl;
            }
            this.setDisplaycars();
        }).catch((error) => {
            console.log(error);
        });
    }

    //Set which cars to be displayed
    setDisplaycars() {
        this.displayCars = [];        
        let carNumber = this.futureCars.length;
        if(carNumber == 0) return;
        this.displayCars.push(this.futureCars[this.displayIndex]);
        if(carNumber == 1) return;

        if(this.displayIndex + 1 == this.futureCars.length) {
            this.displayCars.push(this.futureCars[0]);
        } else {
            this.displayCars.push(this.futureCars[this.displayIndex + 1]);
        }
    }

    //Handler for click up arrow button
    handleUpAction(e) {
        this.displayIndex--;
        if(this.displayIndex == -1) {
            this.displayIndex = this.futureCars.length - 1;
        }
        this.setDisplaycars();
    }

    //Handler for click down arrow button
    handleDownAction(e) {
        this.displayIndex++;
        if(this.displayIndex == this.futureCars.length) {
            this.displayIndex = 0;
        }
        this.setDisplaycars();
    }
}