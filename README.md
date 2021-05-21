Pollen

This QuickApp (for the Fibaro Homecenter 3) gives access to real-time pollen count - tree, grass and weed, of any location in Asia, Europe, North America, Australia and New Zealand by latitude and longitude. 

Pollen is a fine powder produced by trees and plants. 
=Pollen can severely affect people, especially those with different ailments such as asthma and respiratory issues. 
=It can aggravate these existing conditions or cause these issues in high risk groups.

=Grass Pollen:	Pollen grains from grasses. Measuring unit is pollen particles/m³
=Tree Pollen:	Pollen from trees such as Birch and Oak. Measuring unit is pollen particles/m³

The QuickApp provides a risk evaluation with levels 
- Low - Mild risk to those with severe respiratory issues. No risk for the general public 
- Moderate - Risky for those with severe respiratory problems. Mild risk for the general public 
- High - Risky for all groups of people 
- Very High - Highly risky for all groups of people

IMPORTANT
You need an API key form https://www.getambee.com.  
The API is free up to 100 API calls/day, with zero limitations on country, access to air quality, pollen, weather and fire data and dedicated support 


Version 0.1 (8th May 2021)
- Initial version


See also https://www.getambee.com to get a API key


Variables (mandatory): 
- apiKey = Get your free API key from https://www.getambee.com
- interval = [number] in seconds time to get the sensor data from sensor.community
- timeout = [number] in seconds for http timeout
- debugLevel = Number (1=some, 2=few, 3=all, 4=simulation mode) (default = 1)
- icon = [numbber] User defined icon number (add the icon via an other device and lookup the number)
