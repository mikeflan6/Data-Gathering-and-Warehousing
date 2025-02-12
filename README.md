**#NJ Pine Trees 1998-2025**
Where is the data from? ​
**Data was extracted by account user Michael Flanagan using the Download feature on inaturalist.org. Data is in .csv file format.**
How was it collected?​ 
How is the data validated to ensure consistency?​
**Data is crowdsourced by iNaturalist users making observations in the wild. These observations are reviewed within the community to varify finding and ensure quality standards. Verified observations are labels as "Research-Grade" and can be used for scientific reserch.**
What program was used to clean the data?​
**Python was used to condense and clean the dataset into a useable dataframe.**
How was the data cleaned or transformed? Be specific.​
**Data was analyzed and condensed within Python. The original dataset contained 40 columns and 8,907 rows with a file size of 4.437MB. This was reduced to 11 columns and 3,844 rows with a file size of 0.684MB. Only rows containing element "research" in column "quality_grade" were kept. The following columns were then ommitted from the dataset:
Id
Uuid
Observed_on_string
Time_zone
User_login
Quality_grade
License
Url
Image_url
Sound_url
Tag_list
Description
Num_identification_agreements
Num_identification_disagreements
Captive_cultivated
Oauth_application_id
Place_guess
Positional_accuracy
Private_place_guess
Private_latitude
Private_longitude
Public_positional_accuracy
Geoprivacy
Taxon_geoprivacy
Coordinates_obscured
Positioning_method
Positioning_device
Iconic_taxon_name
Taxon_id**
What are the definitions for the column names? Include all columns of your dataset and the type of data it is.​
What are the units of the numeric data?​
What were the formulas used in column creation(s)?​
**Columns included in the condensed dataframe include:
Observed_on
Time_observed_at
User_id
User_name
created_at
Updated_at
Latitude
Longitude
Species_guess
Scientific_name
Common_name**

What are the regulations to using the data?
