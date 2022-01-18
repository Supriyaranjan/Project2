({
    Initialize: function (component, event, helper) {
        component.set("v.showCurrentproduct", false);
        component.set("v.greeting", "Show current product info");
    },
    handleClick: function (component, event, helper) {
        let currentV = component.get("v.showCurrentproduct");
        if(currentV === true) {
            component.set("v.showCurrentproduct", false);
            component.set("v.greeting", "Show current product info");
        } else {
            component.set("v.showCurrentproduct", true);
            component.set("v.greeting", "Hide current product info");
        }
        
    }
})
