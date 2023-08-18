public with sharing class SetHighPriorityOnBillsHandler {
    public static void SetHighPriorityOnBills(List<Bill__c> bills) {
        for (Bill__c bill : bills) {
            // Check if the bill's due date is within the next three days
            if (bill.Due_Date__c != null && bill.Due_Date__c <= Date.today().addDays(3)) {
                bill.High_Priority__c = true;
            } 
        }
    }
}