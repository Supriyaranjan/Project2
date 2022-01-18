import { LightningElement, api } from 'lwc';
export default class Logoutbutton extends LightningElement {

@api
userName;

    logout()
     {
        console.log('logout');
       window.location.replace("https://teamamplifire-developer-edition.na213.force.com/login");
      // window.location.replace("https://teamamplifire-developer-edition.na213.force.com/servlet/networks/switch?startURL=%2Fsecur%2Flogout.jsp");
    
     } 

}