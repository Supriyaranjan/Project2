trigger CaseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete, after undelete) {


      // We should be able to handle every case
      switch on trigger.operationType {
        when BEFORE_INSERT { // Fires on Upsert
            
          
            
        }
        when BEFORE_UPDATE { // Fires on Upsert and Merge
            
        }
        when BEFORE_DELETE { // Fires on Merge
            // Must use trigger.old here
            CaseHandler.RestrictCaseDelete(trigger.old);
        }
        when AFTER_INSERT { // Fires on Upsert
       
        }
        when AFTER_UPDATE { // Fires on Upsert and Merge
            // Can use trigger.old here
        }
        when AFTER_DELETE { // Fires on Merge
            // Can use trigger.old here
        }
        when AFTER_UNDELETE {
            
        }
    }
}