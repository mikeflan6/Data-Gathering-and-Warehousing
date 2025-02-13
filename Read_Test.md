# Spotted Lanternfly

## Overview
Observational data was retrieved from [iNaturalist](https://www.inaturalist.org). iNaturalist is a 501(c)(3) non-profit organization that creates a citizen science platform where users contribute biodiversity observations by photograph or sound recording. Observations may include the complete Linnaean classification, GPS locations, and dates. Additional parameters include life stages and type of evidence of life. The website and app contain crowd-sourced data to receive help with species identifications, collaborate with other citizen scientists for a common purpose, or access additional observational data collected by iNaturalist users for ecological or biological research.

**Data Collection**: The data was subsetted for only Spotted Lanternfly (Lycorma delicatula) observations. Data was downloaded as a comma-separated values (CSV) file.

## Method
Python with pandas was used to clean the data.

- The dataset was cleaned to remove observations not within the United States.
- Observations were filtered for “Research Grade” observations, which are confirmed by an identifier or subject matter expert.
- The `.drop` function from pandas removed the columns `uuid`, `private_latitude`, and `private_longitude`.
- The following column names were adjusted using the `rename` function:
  - `place_town_name` to `town`
  - `place_county_name` to `county`
  - `place_state_name` to `state`
  - `place_country_name` to `country`
- A new data frame was created and named `lanternfly1`. The cleaned data was then saved to an updated CSV file named `cleaned_lanternfly.csv`.

## Terminology
- **id**: Observation identification number
- **observed_on_string**: Time and date of observation, not standardized
- **observed_on**: Date of observation, standardized
- **time_observed_at**: Date, time, and time zone of observation, standardized
- **time_zone**: Observation time zone
- **user_id**: User identification number
- **user_login**: User login name on iNaturalist platform that recorded observation
- **user_name**: User first and last name of who conducted observation
- **created_at**: Date, time, and time zone the observation was uploaded to iNaturalist
- **updated_at**: Date, time, and time zone the observation was updated
- **quality_grade**: Quality grade of the observation based on iNaturalist’s standards
- **tag_list**: Additional information user can input when documenting observation, such as life cycle stage
- **description**: User can add a description of the observation
- **num_identification_agreements**: Number of other users who agree with the identification of the species
- **num_identification_disagreements**: Number of users who disagree with the identification of the species
- **captive_cultivated**: If the species is captive or cultivated
- **oauth_application_id**: Identification if observation was uploaded via website or through the app
- **place_guess**: A field the user is able to input the location they found the observation
- **latitude**: Geographical location in decimal degrees
- **longitude**: Geographical location in decimal degrees
- **positional_accuracy**: Positional accuracy of location of observation
- **public_positional_accuracy**: Positional accuracy of location of observation not obscured
- **geoprivacy**: Disclosure of observations location
- **taxon_geoprivacy**: If taxon location is restricted for threatened taxa
- **coordinates_obscured**: Location only visible to iNaturalist staff or researchers
- **positioning_method**: How coordinates were obtained for observation
- **positioning_device**: Device coordinates were obtained for observation
- **town**: Town that the observation was located
- **county**: County where observation was located
- **state**: State where observation was located
- **country**: Country where the observation was located
- **species_guess**: Species guess by the user of what the observation is
- **scientific_name**: Scientific name of the observation
- **common_name**: Common name of the observation
- **iconic_taxon_name**: Taxon name of the observation
- **taxon_id**: Taxon identification of the observation

## Source
iNaturalist community. Observations of Lycorma delicatula from the United States. Exported from [iNaturalist](https://www.inaturalist.org) on 2/8/2025.

