import { LightningElement, api } from 'lwc';
export default class Logoutbutton extends LightningElement {

@api
userName;

    logout()
     {
        console.log('logout');
       window.location.replace("https://testaur-developer-edition.na163.force.com/ExperienceTest/login");

     }
     

}