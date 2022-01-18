({
    myAction : function(component, event, helper) {

    },

    doInit : function(component, event, helper){
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.userId", userId);
        component.set("v.showCase", "false");
        component.set("v.showFutureCar", "false");
        component.set("v.showOrder", "false");
        component.set("v.showCarImages", "false");
        component.set("v.showHome", "true");
    },

    dispCaseTab : function(component, event, helper){

        component.set("v.showCase", "true");
        component.set("v.showHome", "false");
        component.set("v.showFutureCar", "false");
        component.set("v.showOrder", "false");
        component.set("v.showCarImages", "false");
    },

    dispOrderTab : function(component, event, helper){

        component.set("v.showCase", "false");
        component.set("v.showHome", "false");
        component.set("v.showFutureCar", "false");
        component.set("v.showCarImages", "false");
        component.set("v.showOrder", "true");
    },

    dispFutureTab : function(component, event, helper){

        component.set("v.showCase", "false");
        component.set("v.showHome", "false");
        component.set("v.showFutureCar", "true");
        component.set("v.showOrder", "false");
        component.set("v.showCarImages", "false");
    },

    dispCarImagesTab : function(component, event, helper){

        component.set("v.showCase", "false");
        component.set("v.showHome", "false");
        component.set("v.showFutureCar", "false");
        component.set("v.showOrder", "false");
        component.set("v.showCarImages", "true");
    },

    dispHomeTab : function(component, event, helper){

        component.set("v.showCase", "false");
        component.set("v.showFutureCar", "false");
        component.set("v.showOrder", "false");
        component.set("v.showCarImages", "false");
        component.set("v.showHome", "true");
    }
})
