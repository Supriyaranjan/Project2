({
    init : function(component, event, helper){
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        var userName = component.get("v.userName");
        component.set("v.userId", userId);

        var action = component.get("c.getFirstName");
        action.setParams({userIdFromAura : userId});

        action.setCallback(this, function(response) {

            component.set("v.userName", response.getReturnValue());
        });

        $A.enqueueAction(action);

    }

})
