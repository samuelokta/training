trigger MaintenanceRequest on Case (after update) {

    MaintenanceRequestHelper.automateMaintenanceRequests();

}