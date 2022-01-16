({
    doInit : function(component, event, helper) {

        //Create the action
        let action = component.get("c.GetFAQList");
        //Add callback behavior for when response is received
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.faqs", response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
        });

        $A.enqueueAction(action);

    },

    getFaqResult : function(component, event, helper){
        console.log("I am inside Aura faq result");
        let faq_list = event.getParam('faq');
        component.set("v.faqs", faq_list);
    }
})
