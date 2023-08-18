trigger SetHighPriorityOnBills on Bill__c (before insert, before update) {
    // Trigger to set Bills to high priority if bill's due date is within the next three days on before insert
    if (trigger.isInsert && trigger.isBefore) {
        SetHighPriorityOnBillsHandler.SetHighPriorityOnBills(trigger.new);
    }  
    
    // Trigger to set Bills to high priority if bill's due date is within the next three days on before update
    if (trigger.isUpdate && trigger.isBefore) {
        SetHighPriorityOnBillsHandler.SetHighPriorityOnBills(trigger.new);
    }  
        
}