public with sharing class CreateBillingPaymentNoteHandler {
    
    public static void MakeRelatedBillingPaymentNote(List<Bill_Payment__c> payments) {
        
        List<Billing_Payment_Note__c> paymentNotesToInsert = new List<Billing_Payment_Note__c>();
    
        for(Bill__c bill : [SELECT Id, Name, Amount_Remaining__c FROM Bill__c]){
            for (Bill_Payment__c payment : payments) {
                // Check if the payment is fully paid the amount remaining on bill
                
                if (payment.Bill__c == bill.Id && payment.Amount_Paid__c >= bill.Amount_Remaining__c) { 
                    Billing_Payment_Note__c paymentNote = new Billing_Payment_Note__c();
                    paymentNote.Bill_Payment__c = payment.Id;
                
                    paymentNote.Name = 'Paid in full ' + (String.valueOf(payment.Payment_Date__c).removeEnd(' 00:00:00'));
                    paymentNote.Description__c = 'Payment received in full for ' + bill.Name;
                    
                    paymentNotesToInsert.add(paymentNote);
                }
            }
        }

        if (paymentNotesToInsert.size()>0) {
            insert paymentNotesToInsert;
        }
    }
}