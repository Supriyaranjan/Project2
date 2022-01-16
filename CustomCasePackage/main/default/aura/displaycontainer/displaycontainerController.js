({
    myAction : function(component, event, helper) {

    },

    doInit : function(component, event, helper){
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        component.set("v.userId", userId);
        component.set("v.showCase", "false");
        component.set("v.showHome", "true");
    },

    dispCaseTab : function(component, event, helper){

        component.set("v.showCase", "true");
        component.set("v.showHome", "false");
    },

    dispHomeTab : function(component, event, helper){

        component.set("v.showCase", "false");
        component.set("v.showHome", "true");
    }
})
