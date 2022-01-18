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
    constructor(){
        super();
        let newProducts =[{Name:'FutureElectricCar2', 
            Description:'New Electric car', 
            DisplayUrl: '/Electric/2.jpg',
            ProductCode:'0022030'},
            {Name:'FutureSportCar3', 
            Description:'New sport car', 
            DisplayUrl: '/sports/3.jpg',
            ProductCode:'0032028'},
            {Name:'FutureLuxuryCar5', 
            Description:'New Luxury car', 
            DisplayUrl: '/Luxury/5.jpg',
            ProductCode:'0052027'},
            {Name:'FutureLuxuryCar4', 
            Description:'New Luxury car', 
            DisplayUrl: '/Luxury/4.jpg',
            ProductCode:'0042027'},
            {Name:'FutureSportCar2', 
            Description:'New sport car', 
            DisplayUrl: '/sports/2.jpg',
            ProductCode:'0022028'},
            {Name:'FutureElectricCar4', 
            Description:'New Electric car', 
            DisplayUrl: '/Electric/4.jpg',
            ProductCode:'0042027'}
        ];
        getFutureProducts().then(result => {
            this.futureCars = result;
            console.log(result.length);
            if(result.length < 3) {
                for(let i = 0; i < newProducts.length; i++) {
                    saveFutureProduct({currentProduct: newProducts[i]});
                }
                //Set timer to load products again after 200ms
                setTimeout(() => {
                    getFutureProducts().then(result1 => {
                        this.futureCars = result1;
                        for(let i=0; i < this.futureCars.length; i++) {
                            this.futureCars[i].DisplayUrl = Future_Car + this.futureCars[i].DisplayUrl;
                        }
                        this.setDisplaycars();
                    }).catch((error) => {
                        console.log(error);
                    });
                }, 200);
            }
        }).catch((error) => {
            console.log(error);
        });
    }

    //Get data from database when initialize
    connectedCallback() {
        getFutureProducts().then(result => {
            this.futureCars = result;
            for(let i=0; i < this.futureCars.length; i++) {
                this.futureCars[i].DisplayUrl = Future_Car + this.futureCars[i].DisplayUrl;
            }
            this.setDisplaycars();
            console.log("Connected");
            console.log(this.futureCars);
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