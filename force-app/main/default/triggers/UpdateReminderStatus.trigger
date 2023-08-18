trigger UpdateReminderStatus on Billing_Reminder__c (before insert, before update) { 
    // Trigger to change reminder status to active or overdue before insert
    if (trigger.isInsert && trigger.isBefore) {
        UpdateReminderStatusHandler.UpdateReminderStatusBasedOnDueDate(trigger.new);
    }  
    
    // Trigger to change reminder status to active or overdue before update
    if (trigger.isUpdate && trigger.isBefore) {
        UpdateReminderStatusHandler.UpdateReminderStatusBasedOnDueDate(trigger.new);
    }  
              
}