trigger CreateBillingPaymentNote on Bill_Payment__c (after insert, after update) {
        // Trigger to create a note when bill is paid off on payment update or insert
        if (trigger.isInsert && trigger.isAfter) {
            CreateBillingPaymentNoteHandler.MakeRelatedBillingPaymentNote(trigger.new);
        }  
        
        
        if (trigger.isUpdate && trigger.isAfter) {
            CreateBillingPaymentNoteHandler.MakeRelatedBillingPaymentNote(trigger.new);
        }  
}