Notification_Event__e evt = new Notification_Event__e();
evt.Process__c = 'Leads Processing Batch';
evt.Message__c = 'Leads processing has been completed. Go and get your respective processes invoked';
EventBus.publish(evt);