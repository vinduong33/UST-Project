public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecords() {
        return [SELECT Id, Name, Industry, BillingState, Phone FROM Account LIMIT 3]; 
    }

    @AuraEnabled(cacheable=true)
    public static List<Bill__c> getBillRecords() {
        return [SELECT Name, Amount_Due__c, Amount_Remaining__c, Due_Date__c
                FROM Bill__c
                WHERE High_Priority__c = true AND Amount_Remaining__C > 0 
                ORDER BY Due_Date__c ASC LIMIT 3];
    }

    @AuraEnabled(cacheable=true)
    public static List<Bill_Payment__c> getPaymentRecords() {
        return [SELECT Name, Bill__c, Payment_Date__c, Amount_Paid__c, Bill__r.Name
                FROM Bill_Payment__c
                ORDER BY Payment_Date__c ASC LIMIT 3];

    }

    @AuraEnabled(cacheable=true)
    public static List<Billing_Reminder__c> getBillingReminderRecords() {
        return [SELECT Name, Description__c FROM Billing_Reminder__c LIMIT 3];

    }

    @AuraEnabled(cacheable=false)
    public static void deleteReminders(List<Id> reminderIds) {
        List<Billing_Reminder__c> remindersToDelete = [SELECT Id FROM Billing_Reminder__c WHERE Id IN :reminderIds];
        delete remindersToDelete;
    }
}