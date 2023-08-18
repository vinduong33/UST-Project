trigger PreventNoteDeletion on Billing_Payment_Note__c (before delete) {
    // Trigger to prevent Billing Payment Note deletion if the bill has not been fully paid
    if (trigger.isDelete && trigger.isBefore) {
        PreventNoteDeletionHandler.PreventNoteDeletionIfBillIsNotPaid(trigger.old);   
    }  
}