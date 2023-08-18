import { LightningElement, wire, track } from 'lwc';
import getBillingReminderRecords from '@salesforce/apex/AccountController.getBillingReminderRecords';
import deleteReminders from '@salesforce/apex/AccountController.deleteReminders';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Description', fieldName: 'Description__c', type: 'text' }
];

export default class BillingReminderRecordsList extends LightningElement {
    @track reminders = [];
    @track disableDeleteButton = true;
    @track columns = COLUMNS;
    error;
    selectedRows = [];
    wiredResult;

    // Wire service call to fetch billing reminder records
    @wire(getBillingReminderRecords) 
    wiredBillingReminderRecords(result) {
        this.wiredResult = result; // Store the result
        const { data, error } = result;
        if (data) {
            this.reminders = data;
            refreshApex(this.wiredResult);  // Refresh the data to ensure updates
        } else if (error) {
            this.error = error;
            console.error(error);
        }
    }

    // Handle row selection in the data table
    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
        this.disableDeleteButton = this.selectedRows.length === 0;
    }

     // Get an array of selected reminder IDs
    getSelectedReminderIds() {
        return this.selectedRows.map(row => row.Id);
    }

     // Delete selected reminders
    deleteSelectedReminders() {
        const selectedReminderIds = this.getSelectedReminderIds(); // Retrieve the selected reminder IDs
        
        // Call Apex method to delete selected reminders
        deleteReminders({ reminderIds: selectedReminderIds })
            .then(result => {
                console.log('Reminders deleted successfully.');
                this.selectedRows = []; // Clear selected rows
                this.disableDeleteButton = true; // Disable the delete button
                return refreshApex(this.wiredResult); // Delete data
            })
            .catch(error => {
                console.error('Error deleting reminders:', error);
            });
    }
    
}