@isTest
public class CreateBillingPaymentNoteHandler_Test {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   

    @isTest public static void TestCreateBillingPaymentNoteHandler() {
        // Query bill and make a payment that matches amount remaining
        Bill__c bill = [SELECT Id, Amount_Remaining__c FROM Bill__c WHERE Name='Test Bill' LIMIT 1];

        Bill_Payment__c payment = new Bill_Payment__c();
        payment.Bill__c = bill.Id;
        payment.Amount_Paid__c = bill.Amount_Remaining__c;
        payment.Payment_Date__c = Date.today();


        Test.startTest();
        // Insert payment and check to see that related note is created
        insert payment;
        Billing_Payment_Note__c newNote = [SELECT Id, Name, Bill_Payment__c FROM Billing_Payment_Note__c WHERE Name LIKE '%Paid in full%' LIMIT 1];
        Test.stopTest();

        system.assertEquals(payment.Id, newNote.Bill_Payment__c);

    }

    @isTest public static void TestUpdateBillingPaymentNoteHandler() {
        // Query bill and make a payment that is less than amount remaining
        Bill__c bill = [SELECT Id, Amount_Remaining__c FROM Bill__c WHERE Name='Test Bill' LIMIT 1];

        Bill_Payment__c payment = new Bill_Payment__c();
        payment.Bill__c = bill.Id;
        payment.Amount_Paid__c = bill.Amount_Remaining__c - 1;
        payment.Payment_Date__c = Date.today();


        Test.startTest();
        // Check to see that no note is created since payment is less than amount remaining
        insert payment;
        Billing_Payment_Note__c[] zeroNewNote = [SELECT Id, Name, Bill_Payment__c FROM Billing_Payment_Note__c WHERE Name LIKE '%Paid in full%' LIMIT 1];
        system.assertEquals(0, zeroNewNote.size());

        // Change payment to amount remaining and check to see if related note is created
        payment.Amount_Paid__c = bill.Amount_Remaining__c;
        update payment;
        Billing_Payment_Note__c newNote = [SELECT Id, Name, Bill_Payment__c FROM Billing_Payment_Note__c WHERE Name LIKE '%Paid in full%' LIMIT 1];
        Test.stopTest();
       
        system.assertEquals(payment.Id, newNote.Bill_Payment__c);

    }
}