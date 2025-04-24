# Arborist Elite of Garden State Manor
**New Jersey's Premier Log Cabin Suppliers**

##  A fictional company created to demonstrate knowledge of comprehensive database systems. This project showcases implementation and demonstration of how a database can be used for analysis by collecting, storing, and retrieving data.

### Where is the data from?
Data is collected from iNaturalist, USDA FIA Datamart, randomly generated data from Mockaroo, and the creative minds of Michael Flanagan and Andrew Morales

### How was it collected?
Data is crowdsourced by iNaturalist users making observations in the wild. These observations are reviewed within the community to verify findings and ensure quality standards. Verified observations are labeled as "Research-Grade" and can be used for scientific research. Data from the USDA is collected by employees making field observations of inventoried trees.

### What program was used to clean the data?
R was used to create the "inventory" for Arborist_Elite. Data from both iNaturalist and the USDA were manipulated and combined into a single master dataset
Python was used to create the database within MySQL Workbench
MySQL Workbench was used to generate the schema for the Arborist Elite database and run queries

### What are the definitions for the column names?
Columns included in the condensed dataframe include:

- **Observed_on**: The date when the observation was made (**YEAR-MONTH-DAY**)
- **Time_observed_at**: The date(**YEAR-MONTH-DAY**), military time (**HOUR-MINUTE-SECOND**), and time zone (**+xxxx**) when the observation was made 
- **User_id**: A unique identification number for the user who made the observation
- **User_name**: The username of the individual who made the observation
- **created_at**: The date(**YEAR-MONTH-DAY**), military time (**HOUR-MINUTE-SECOND**), and time zone (**+xxxx**) when the observation was first recorded on iNaturalist
- **Updated_at**: The date(**YEAR-MONTH-DAY**), military time (**HOUR-MINUTE-SECOND**), and time zone (**+xxxx**) when the observation was last updated on iNaturalist
- **Latitude**: The latitude coordinates where the observation was made
- **Longitude**: The longitude coordinates where the observation was made
- **Species_guess**: The users guess at the species of the observation
- **Scientific_name**: The scientific name of the observation
- **Common_name**: The common name of the observation

## Regulations to Using the Data
[Terms of use](https://www.inaturalist.org/pages/terms) for the iNaturalist website and accompanying data 
