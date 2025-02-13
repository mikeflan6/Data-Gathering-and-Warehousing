# NJ Pine Trees
**iNaturalist Pine Tree Observations from 1998-2025**

## Data Information

### Where is the data from?
Data was extracted by account user Michael Flanagan using the Download feature on [iNaturalist](inaturalist.org). Data is in .csv file format.

### How was it collected?
Data is crowdsourced by iNaturalist users making observations in the wild. These observations are reviewed within the community to verify findings and ensure quality standards. Verified observations are labeled as "Research-Grade" and can be used for scientific research.

### How is the data validated to ensure consistency?
Data is crowdsourced by iNaturalist users making observations in the wild. These observations are reviewed within the community to verify findings and ensure quality standards. Verified observations are labeled as "Research-Grade" and can be used for scientific research.

### What program was used to clean the data?
Python was used to condense and clean the dataset into a usable dataframe.

### How was the data cleaned or transformed?
Data was analyzed and condensed within Python. The original dataset contained 40 columns and 8,907 rows with a file size of 4.437MB. This was reduced to 11 columns and 3,844 rows with a file size of 0.684MB. Only rows containing the element "research" in the column "quality_grade" were kept. The following columns were then omitted from the dataset:

- Id
- Uuid
- Observed_on_string
- Time_zone
- User_login
- Quality_grade
- License
- Url
- Image_url
- Sound_url
- Tag_list
- Description
- Num_identification_agreements
- Num_identification_disagreements
- Captive_cultivated
- Oauth_application_id
- Place_guess
- Positional_accuracy
- Private_place_guess
- Private_latitude
- Private_longitude
- Public_positional_accuracy
- Geoprivacy
- Taxon_geoprivacy
- Coordinates_obscured
- Positioning_method
- Positioning_device
- Iconic_taxon_name
- Taxon_id

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
