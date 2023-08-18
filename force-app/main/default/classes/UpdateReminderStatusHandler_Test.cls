@isTest
public with sharing class UpdateReminderStatusHandler_Test {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   
    
    @isTest public static void TestUpdateReminderStatusHandlerOnInsert() {
        // Query bill and make a reminder with due date in the future
        Bill__c bill = [SELECT Id, High_Priority__c FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];
        Billing_Reminder__c reminder = new Billing_Reminder__c();
        reminder.Bill__c = bill.Id;
        reminder.Name = 'Test Reminder';
        reminder.Due_Date__c = Date.today().addDays(1);

        Test.startTest();
        // Insert and query reminder
        insert reminder;
        Billing_Reminder__c r = [SELECT Id, Reminder_Status__c FROM Billing_Reminder__c WHERE Name = 'Test Reminder' LIMIT 1];
        Test.stopTest();
        
        // Check reminder status is "Active"
        system.assertEquals('Active', r.Reminder_Status__c);
    }

    @isTest public static void TestUpdateReminderStatusHandlerOnUpdate() {
         // Query bill and make a reminder with due date in the future
        Bill__c bill = [SELECT Id, High_Priority__c FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];
        Billing_Reminder__c reminder = new Billing_Reminder__c();
        reminder.Bill__c = bill.Id;
        reminder.Name = 'Test Reminder';
        reminder.Due_Date__c = Date.today().addDays(1);

        Test.startTest();
        // Insert, udpate reminder to a due date in the past, and query reminder
        insert reminder;
        reminder.Due_Date__c = Date.today().addDays(-1);
        update reminder;
        Billing_Reminder__c r = [SELECT Id, Reminder_Status__c FROM Billing_Reminder__c WHERE Name = 'Test Reminder' LIMIT 1];
        Test.stopTest();
        
        // Check reminder status is "Overdue"
        system.assertEquals('Overdue', r.Reminder_Status__c);
    }
}