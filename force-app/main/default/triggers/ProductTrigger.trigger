trigger ProductTrigger on Product2 (before insert) {
    switch on trigger.operationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            FutureProductController.checkFutureKeyword(trigger.new);
        }
    }
}