public with sharing class ContractTriggerHelper {
    
    public static Boolean contactDuplicate(List<Contract> newContracts){
        //result variable
        Boolean result = true;
        //list of current Contracts in the database
        List<Contract> currContracts = [SELECT Id, Contact__c FROM Contract];
        //loop through new Contracts
        for(Contract newContract : newContracts){
            //check it Contact__c exists
            if(String.isBlank(newContract.Contact__c)){
                newContract.addError('ERROR: Need Contact Id in Contact__c field');
                result = false;
            }//end if no ContactId is entered
            //loop through current contracts to see if the contact is shared
            for(Contract currContract : currContracts){
                if((newContract.Contact__c == currContract.Contact__c) && currContract.Contact__c != null){
                    newContract.addError('ERROR: ContactId already exists');
                    result = false;
                }//end if ContactId is same 
            }//end for currContracts
        }//end for newContracts
        return result;
    }//end contactDuplicate
}//end ContractTriggerHelper
