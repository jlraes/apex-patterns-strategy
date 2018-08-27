@isTest
public class GeocoderTest {

    private final static String TEST_LOCATION_NAME = 'Moscone Center';

    @testSetup
    static void setUp() {
        My_Settings__c settings = My_Settings__c.getInstance('strategies');
        if (settings == null) {
            settings = new My_Settings__c(Name='strategies');
        }
        settings.value__c = 'GoogleMaps,MapQuest';
        upsert(settings);
    }

    static testMethod void getLatLong_works_with_GoogleMaps() {
        Geocoder geocoder = new Geocoder('GoogleMaps');
        Double[] coords = geocoder.getLatLong(TEST_LOCATION_NAME);
        System.assert(coords != null);
        System.assertEquals(2, coords.size());
        System.assertEquals(0, coords[0]);
        System.assertEquals(0, coords[1]);
    }

    static testMethod void getLatLong_works_with_MapQuest() {
        Geocoder geocoder = new Geocoder('MapQuest');
        Double[] coords = geocoder.getLatLong(TEST_LOCATION_NAME);
        System.assert(coords != null);
        System.assertEquals(2, coords.size());
        System.assertEquals(1, coords[0]);
        System.assertEquals(1, coords[1]);
    }

    static testMethod void constructor_fails_with_unknown_strategy() {
        try {
            new Geocoder('SomeUnknownStrategy');
            System.assert(false, 'Geocoder constructor should fail with unknonw strategy');
        }
        catch (Geocoder.UnknownStrategyException e) {
            System.assert(true);
        }
    }
}
