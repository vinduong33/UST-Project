trigger PreventCategoryDeletion on Billing_Category__c (before delete) {
     // Trigger to prevent Billing Category deletion if it is related to an unpaid bill  
    if (trigger.isDelete && trigger.isBefore) {
        PreventCategoryDeletionHandler.PreventCategoryDeletion(trigger.old);   
    }  
                                 
}