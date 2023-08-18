import { LightningElement, wire, track } from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountController.getAccountRecords';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Location', fieldName: 'BillingState', type: 'address' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' }
];

export default class AccountRecordsList extends LightningElement {
    @track accounts = [];
    @track columns = COLUMNS;
    error;
    wiredResult; 

    // Wire service call to fetch account records
    @wire(getAccountRecords) 
    wiredAccountRecords(result) {
        this.wiredResult = result; // Store the result
        const { data, error } = result;
        if (data) {
            this.accounts = data;
            refreshApex(this.wiredResult); // Refresh the data to ensure updates
        } else if (error) {
            this.error = error;
            console.error(error);
        }
    }
}