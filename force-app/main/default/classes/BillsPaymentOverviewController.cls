public class BillsPaymentOverviewController {
    public List<Account> accountsWithBills {get; set;}
    public List<Bill__c> highPriorityBills { get; set; }
    public List<Bill_Payment__c> payments { get; set; }
    public List<Billing_Reminder__c> reminders { get; set; }

    public BillsPaymentOverviewController() {
        // Query accounts with bills
        accountsWithBills = [SELECT Id, Name,
                                    (SELECT Id, Name
                                     FROM Bills__r) 
                              FROM Account WHERE Id IN (SELECT Account__c FROM Bill__c)];
        
        // Query high priority bills with outstanding balance
        highPriorityBills = [SELECT Name, Amount_Due__c, Amount_Remaining__c, Due_Date__c
                            FROM Bill__c
                            WHERE High_Priority__c = true AND Amount_Remaining__C > 0 
                            ORDER BY Due_Date__c ASC];

        // Query total payments made
        payments = [SELECT Name, Bill__r.Account__r.Name, Amount_Paid__c, Payment_Date__c
                            FROM Bill_Payment__c
                            ORDER BY Payment_Date__c ASC];

        // Query reminders that are overdue
        reminders = [SELECT Name, Description__c, Due_Date__c
                     FROM Billing_Reminder__c
                     WHERE Reminder_Status__c = 'Overdue'
                     ORDER BY Due_Date__c ASC];
    }

}