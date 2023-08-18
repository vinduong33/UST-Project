@isTest
public with sharing class PreventNoteDeletionHandler_Test {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   
    
    @isTest public static void TestPreventNoteDeletionHandler() {
       // Query bill and a payment that is less than amount remaining      
        Bill__c bill = [SELECT Id, Amount_Remaining__c FROM Bill__c WHERE Name = 'Test Bill' LIMIT 1];
        
        Bill_Payment__c payment = new Bill_Payment__c();
        payment.Bill__c = bill.Id;
        payment.Amount_Paid__c = bill.Amount_Remaining__c - 1;
        payment.Payment_Date__c = Date.today();
        
        try {
            // Insert payment, insert note, and try deleting the note
            Test.startTest();
            insert payment;
            Billing_Payment_Note__c note = new Billing_Payment_Note__c();
            note.Bill_Payment__c = payment.Id;
            note.Name = 'Pay This';
            insert note;
            delete note;
            Test.stopTest();

        } catch (Exception e) {
            // Check for error message
            Boolean expectedExceptionThrown =  e.getMessage().contains('Cannot delete a Billing Payment Note with an unpaid bill.') ? true : false;
            system.assertEquals(true, expectedExceptionThrown);
        }
    }
}