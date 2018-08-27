public class Geocoder {
    public class UnknownStrategyException extends Exception {}
    
    public static final Map<String, GeocodeService> strategies;

    static {
        // Retrieve comma delimited list of strategies from a custom setting list
        My_Settings__c settings = My_Settings__c.getInstance('strategies');

        // Parse and populate a list of strategy names (GoogleMaps, MapQuest)
        List<String> strategyNames = new List<String>();
        if (settings != null && settings.value__c != null) {
            String[] names = settings.value__c.split(',');
            for (String name : names) {
                name = name.trim();
                if (name.length() > 0) {
                    strategyNames.add(name);
                }
            }
        }

        // Populate a map of strategy names to concrete implementations
        // using Type.forName for each strategy name
        strategies = new Map<String,GeocodeService>();
        for (String strategyName : strategyNames) {
            String className = strategyName + 'Impl';
            try {
                strategies.put(strategyName, (GeocodeService) Type.forName(className).newInstance());
            }
            catch (Exception e) {
                System.debug(LoggingLevel.ERROR, 'Could not '+ className +' class associated with '+ strategyName +' Geocoder strategy');
                continue; // Continute to load other strategies
            }
        }
    }

    private GeocodeService strategy;

    public Geocoder(String strategyName) {
        if (!strategies.containsKey(strategyName)) {
            throw new UnknownStrategyException('Unkown Geocoder strategy: '+ strategyName);
        }
        strategy = strategies.get(strategyName);
    }

    public List<Double> getLatLong(String address) {
        return strategy.getLatLong(address);
    }
}
