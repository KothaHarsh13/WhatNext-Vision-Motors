global class VehicleOrderBatchScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        // Create instance of batch class
        VehicleOrderBatch batchJob = new VehicleOrderBatch();

        // Execute the batch job with a batch size of 50
        Database.executeBatch(batchJob, 50);
    }
}
