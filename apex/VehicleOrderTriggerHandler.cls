public class VehicleOrderTriggerHandler {    

    public static void handleTrigger(
        List<Vehicle_Order__c> newOrders,
        Map<Id, Vehicle_Order__c> oldOrders,
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate
    ) {
        if (isBefore) {
            if (isInsert || isUpdate) {
                preventOrderIfOutOfStock(newOrders);
            }
        }

        if (isAfter) {
            if (isInsert || isUpdate) {
                updateStockOnOrderPlacement(newOrders, oldOrders);
            }
        }
    }

    // Prevent placing orders for vehicles that are out of stock
    private static void preventOrderIfOutOfStock(List<Vehicle_Order__c> orders) {
        Set<Id> vehicleIds = new Set<Id>();

        for (Vehicle_Order__c order : orders) {
            if (order.Vehicle__c != null) {
                vehicleIds.add(order.Vehicle__c);
            }
        }

        if (!vehicleIds.isEmpty()) {
            Map<Id, Vehicle__c> vehicleStockMap = new Map<Id, Vehicle__c>(
                [SELECT Id, Stock_Quality__c FROM Vehicle__c WHERE Id IN :vehicleIds]
            );

            for (Vehicle_Order__c order : orders) {
                if (vehicleStockMap.containsKey(order.Vehicle__c)) {
                    Vehicle__c vehicle = vehicleStockMap.get(order.Vehicle__c);
                    if (vehicle.Stock_Quality__c <= 0) {
                        order.addError('This vehicle is out of stock. Order cannot be placed.');
                    }
                }
            }
        }
    }

    // Deduct stock only when order is newly confirmed
    private static void updateStockOnOrderPlacement(List<Vehicle_Order__c> newOrders, Map<Id, Vehicle_Order__c> oldOrders) {
        Set<Id> vehicleIdsToUpdate = new Set<Id>();
        Map<Id, Integer> vehicleOrderCounts = new Map<Id, Integer>();

        for (Vehicle_Order__c newOrder : newOrders) {
            if (newOrder.Status__c == 'Confirmed' && newOrder.Vehicle__c != null) {
                // Insert or transition from other status to 'Confirmed'
                if (oldOrders == null || 
                    !oldOrders.containsKey(newOrder.Id) || 
                    oldOrders.get(newOrder.Id).Status__c != 'Confirmed') {

                    Id vehicleId = newOrder.Vehicle__c;
                    vehicleIdsToUpdate.add(vehicleId);

                    if (!vehicleOrderCounts.containsKey(vehicleId)) {
                        vehicleOrderCounts.put(vehicleId, 1);
                    } else {
                        vehicleOrderCounts.put(vehicleId, vehicleOrderCounts.get(vehicleId) + 1);
                    }
                }
            }
        }

        if (!vehicleIdsToUpdate.isEmpty()) {
            Map<Id, Vehicle__c> vehicleMap = new Map<Id, Vehicle__c>(
                [SELECT Id, Stock_Quality__c FROM Vehicle__c WHERE Id IN :vehicleIdsToUpdate]
            );

            List<Vehicle__c> vehiclesToUpdate = new List<Vehicle__c>();

            for (Id vehicleId : vehicleOrderCounts.keySet()) {
                if (vehicleMap.containsKey(vehicleId)) {
                    Vehicle__c vehicle = vehicleMap.get(vehicleId);
                    Integer toDeduct = vehicleOrderCounts.get(vehicleId);

                    // Ensure stock doesn't go negative
                    vehicle.Stock_Quality__c = Math.max(0, vehicle.Stock_Quality__c - toDeduct);
                    vehiclesToUpdate.add(vehicle);
                }
            }

            if (!vehiclesToUpdate.isEmpty()) {
                update vehiclesToUpdate;
            }
        }
    }
}
