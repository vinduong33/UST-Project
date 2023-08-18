public class UpdateReminderStatusHandler {
    public static void UpdateReminderStatusBasedOnDueDate(List<Billing_Reminder__c> reminders) {
        for (Billing_Reminder__c reminder : reminders) {
            // Check if the Reminder Status is not "Completed" or "Cancelled"
            if (reminder.Reminder_Status__c != 'Completed' && reminder.Reminder_Status__c != 'Cancelled') {
                // Check if the Due Date is in the future
                if (reminder.Due_Date__c >= System.today()) {
                    // Set the Reminder Status to "Active" for future or present reminders
                    reminder.Reminder_Status__c = 'Active';
                } else {
                    // Set the Reminder Status to "Overdue" for past reminders
                    reminder.Reminder_Status__c = 'Overdue';
                }
            }
        }
    }
}