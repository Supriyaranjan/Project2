public with sharing class CaseHandler {

      public static void RestrictCaseDelete(List<Case> caseToDelete){
        for(Case currCase:caseToDelete){
            if(currCase.status=='Working'){
                //System.debug('working');
               currCase.addError('Can not Delete this case');
            }
            
        } 
    }
}
