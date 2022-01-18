({
    DoInit: function (component) {
        let getFutureCars = component.get("c.getFutureProducts");
        // getFutureCars.setParams({ name: 'test name' });

        //getFutureCars.setParams({ name: 'Tom' });
        getFutureCars.setCallback(this, function (response) {
            if (response.getState() == 'SUCCESS') {
                component.set("v.futureCars", response.getReturnValue());
            }
            else if (response.getState() == 'ERROR') {
                console.error(response.getError()[0].message);
            }
        });
        $A.enqueueAction(getFutureCars);
    }
})
