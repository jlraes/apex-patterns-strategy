# Apex Design Patterns: Strategy

This repository demonstrate the **strategy** design pattern implemented in Apex.

The example exposes a `Geocoder` search engine that returns the coordinate of a location.
The service can use different strategies to retrieve the result: we provide mocks for GoogleMaps or MapQuest.
The available strategies are defined in a `My_Settings__c` custom settings list.

Check out the `GeocoderTest` test class to see how to use the service.

# Installation

Create a scratch org:<br/>
`sfdx force:org:create -a pattern -s -f config/project-scratch-def.json`

Push source to scratch org:<br/>
`sfdx force:source:push`

Run Apex tests and get code coverage:<br/>
`sfdx force:apex:test:run -c -r human -w 10`