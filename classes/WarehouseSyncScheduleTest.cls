@isTest
private class WarehouseSyncScheduleTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void syncScheduleTest() {

        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
        String jobId;

        Test.startTest();

            jobId = system.schedule('Warehouse Sync Schedule', CRON_EXP, new WarehouseSyncSchedule());

        Test.stopTest();


    }
}
