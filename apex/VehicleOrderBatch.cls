global class VehicleOrderBatch implements Database.Batchable<sObject> {

    // Step 1: Start method - fetch all pending orders
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Vehicle__c 
            FROM Vehicle_Order__c 
            WHERE Status__c = 'Pending'
        ]);
    }

    // Step 2: Execute method - confirm orders if stock is available
    global void execute(Database.BatchableContext bc, List<Vehicle_Order__c> orderList) {
        Set<Id> vehicleIds = new Set<Id>();

        // Gather all vehicle IDs from the orders
        for (Vehicle_Order__c order : orderList) {
            if (order.Vehicle__c != null) {
                vehicleIds.add(order.Vehicle__c);
            }
        }

        if (!vehicleIds.isEmpty()) {
            // Fetch vehicles with their stock
            Map<Id, Vehicle__c> vehicleStockMap = new Map<Id, Vehicle__c>(
                [SELECT Id, Stock_Quality__c FROM Vehicle__c WHERE Id IN :vehicleIds]
            );

            List<Vehicle_Order__c> ordersToUpdate = new List<Vehicle_Order__c>();
            List<Vehicle__c> vehiclesToUpdate = new List<Vehicle__c>();

            for (Vehicle_Order__c order : orderList) {
                if (vehicleStockMap.containsKey(order.Vehicle__c)) {
                    Vehicle__c vehicle = vehicleStockMap.get(order.Vehicle__c);

                    if (vehicle.Stock_Quality__c > 0) {
                        // Confirm the order and reduce stock
                        order.Status__c = 'Confirmed';
                        vehicle.Stock_Quality__c -= 1;

                        ordersToUpdate.add(order);
                        vehiclesToUpdate.add(vehicle);
                    }
                }
            }

            // Update the confirmed orders
            if (!ordersToUpdate.isEmpty()) {
                update ordersToUpdate;
            }

            // Update the vehicles with reduced stock
            if (!vehiclesToUpdate.isEmpty()) {
                update vehiclesToUpdate;
            }
        }
    }

    // Step 3: Finish method - log completion
    global void finish(Database.BatchableContext bc) {
        System.debug('✅ VehicleOrderBatch job completed successfully.');
    }
}
