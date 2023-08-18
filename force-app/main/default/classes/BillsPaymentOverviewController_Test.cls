@isTest
public class BillsPaymentOverviewController_Test {
   
    @TestSetup
    static void makeData(){
        TestDataFactory.MakeBill();
    }   

    @isTest public static void TestBillsPaymentOverviewController() {
        // Create an account
        List<Account> accounts = new List<Account>();
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;
        accounts.add(account);

        // Query bill and link it with account
        Bill__c bill = [SELECT Id, Account__c, Name, Amount_Due__c, Amount_Remaining__c, Due_Date__c, High_Priority__c FROM Bill__c WHERE Name='Test Bill' LIMIT 1];
		bill.Account__c = account.Id;
        update bill;

        // Create test data for payments
        List<Bill_Payment__c> payments = new List<Bill_Payment__c>();
        payments.add(new Bill_Payment__c (
        Bill__c = bill.Id,
        Amount_Paid__c = bill.Amount_Remaining__c - 1,
        Payment_Date__c = Date.today()));

        // Create test data for reminders
        List<Billing_Reminder__c> reminders = new List<Billing_Reminder__c>();
        reminders.add(new Billing_Reminder__c (
        Bill__c = bill.Id,
        Name = 'Test Reminder',
        Due_Date__c = Date.today().addDays(-3)));
        
        Test.startTest();
        insert payments;
        insert reminders;
        Test.stopTest();
        
        // Instantiate the controller
        BillsPaymentOverviewController controller = new BillsPaymentOverviewController();

        // Test the constructor - check if bill, payment, and reminders  are not empty
        System.assertEquals(false, controller.accountsWithBills.isEmpty());
        System.assertEquals(false, controller.highPriorityBills.isEmpty());
        System.assertEquals(false, controller.payments.isEmpty());
        System.assertEquals(false, controller.reminders.isEmpty());
    }
}