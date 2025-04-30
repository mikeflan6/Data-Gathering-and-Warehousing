#Libraries
library(tidyverse)
library(stringr)

#working directory
setwd("")

#files
inat_trees<-read.csv("inat_tree.csv")         #contains research grade pine trees in New Jersey sourced from iNaturalist
USDA_trees<-read.csv("USDA_NJ_Pine.csv")      #contains inventoried pine trees in New Jersey sourced from USDA FIA Datamart

#remove the word "Pinus" from the 'scientific_name' column
inat_trees$scientific_name <- gsub("Pinus", "", inat_trees$scientific_name)

#display all unique elements in the 'scientific_name' column
unique_scientific_names <- unique(inat_trees$scientific_name)

#remove leading/trailing spaces and filter rows containing the specified species
inat_trees <- inat_trees %>%
  filter(str_trim(scientific_name) %in% c("rigida", "echinata", "strobus", 
                                          "sylvestris", "virginiana", 
                                          "taeda", "resinosa", "serotina"))

#Min and Max "DIA" value of each unique species in "USDA_trees"
min_max_dia_per_species <- USDA_trees %>%
  group_by(SPECIES) %>%
  summarise(
    min_DIA = min(DIA, na.rm = TRUE),
    max_DIA = max(DIA, na.rm = TRUE)
  )

#rename column 'scientific_name' to 'SPECIES'
inat_trees <- inat_trees %>%
  rename(SPECIES = scientific_name)


#remove leading and trailing spaces from the 'SPECIES' column
inat_trees$SPECIES <- str_trim(inat_trees$SPECIES)

#set seed for reproducibility
set.seed(123)

#using the min and max "DIA" values for each unique species in "USDA_trees" generate unique random DIA values rounded to one decimal place for each tree in "inat_trees"
inat_trees <- inat_trees %>%
  rowwise() %>% 
  mutate(DIA = round(case_when(
    SPECIES == "echinata"   ~ runif(1, 9, 22.5),
    SPECIES == "resinosa"   ~ runif(1, 9, 15.6),
    SPECIES == "rigida"     ~ runif(1, 9, 24.9),
    SPECIES == "serotina"   ~ runif(1, 9.8, 16.4),
    SPECIES == "strobus"    ~ runif(1, 9, 34.4),
    SPECIES == "sylvestris" ~ runif(1, 10.2, 16.9),
    SPECIES == "taeda"      ~ runif(1, 10.4, 21.5),
    SPECIES == "virginiana" ~ runif(1, 9.1, 21.2),
    TRUE ~ NA_real_ 
  ), 1)) %>% 
  ungroup() 

#extract unique pairs of 'COMMON_NAME' and 'SPECIES'
unique_pairs <- USDA_trees %>%
  distinct(COMMON_NAME, SPECIES)

#rename the column 'scientific_name' to 'SPECIES'
inat_trees <- inat_trees %>%
  rename(COMMON_NAME = common_name)

#update 'COMMON_NAME' using the corresponding 'SPECIES' values
inat_trees <- inat_trees %>%
  mutate(COMMON_NAME = case_when(
    SPECIES == "rigida"     ~ "pitch pine",
    SPECIES == "echinata"   ~ "shortleaf pine",
    SPECIES == "strobus"    ~ "eastern white pine",
    SPECIES == "virginiana" ~ "Virginia pine",
    SPECIES == "resinosa"   ~ "red pine",
    SPECIES == "serotina"   ~ "pond pine",
    SPECIES == "taeda"      ~ "loblolly pine",
    SPECIES == "sylvestris" ~ "Scotch pine",
    TRUE ~ COMMON_NAME
  ))

#Min and Max "VOLBFNET" value of each unique species in "USDA_trees"
min_max_VOLBFNET_per_species <- USDA_trees %>%
  group_by(SPECIES) %>%
  summarise(
    min_VOLBFNET = min(VOLBFNET, na.rm = TRUE),
    max_VOLBFNET = max(VOLBFNET, na.rm = TRUE)
  )

#calculate the correlation coefficient
#correlation coefficient used to generate random "VOLBFNET" in "inat_trees" 
correlation <- cor(USDA_trees$DIA, USDA_trees$VOLBFNET, use = "complete.obs")

#print the result
print(correlation)

#create a scatter plot
ggplot(USDA_trees, aes(x = DIA, y = VOLBFNET)) +
  geom_point() +
  labs(title = "Scatter Plot of DIA vs VOLBFNET",
       x = "Diameter (DIA)",
       y = "Net Volume (VOLBFNET)") +
  theme_minimal()

#fit the linear model
model <- lm(VOLBFNET ~ DIA, data = USDA_trees)

#print model summary to see the equation
summary(model)


#predict VOLBFNET for inat_trees based on DIA
inat_trees <- inat_trees %>%
  mutate(predicted_VOLBFNET = predict(model, newdata = inat_trees))
set.seed(123) # For reproducibility
inat_trees <- inat_trees %>%
  mutate(VOLBFNET = round(predicted_VOLBFNET + rnorm(n(), mean = 0, sd = 10), 1))

#remove column "predicted_VOLBFNET" from "inat_trees"
inat_trees <- inat_trees %>% select(-predicted_VOLBFNET)
summary(USDA_trees)
glimpse(USDA_trees)

#remove columns "observed_on", "user_id", "updated_at", and "species_guess" from "inat_trees"
inat_trees <- inat_trees %>%
  select(-observed_on, -user_id, -updated_at, -species_guess)

#remove columns "INVYR", "TREE", "CN", "PLT_CN", "COUNTYCD", "SPCD",and "GENUS" from "USDA_trees"
USDA_trees <- USDA_trees %>%
  select(-INVYR, -TREE, -CN, -PLT_CN,-COUNTYCD,-SPCD,-GENUS)
#remove column "primary_key" from "inat_trees"
inat_trees<-inat_trees%>%
  select(-primary_key)

#define the start and end dates
start_date <- as.POSIXct("1991-01-01 00:00:00 +0100", tz = "CET")
end_date <- as.POSIXct("2012-10-15 00:32:47 +0100", tz = "CET")

#generate random timestamps
set.seed(123) # Optional, for reproducibility
random_times <- runif(nrow(USDA_trees), min = as.numeric(start_date), max = as.numeric(end_date))

#add the `created_at` column to `USDA_trees`
USDA_trees$created_at <- as.POSIXct(random_times, origin = "1970-01-01", tz = "CET")

#reorder columns in USDA_trees
USDA_trees <- USDA_trees[, c("created_at", "LAT", "LON", "SPECIES", "COMMON_NAME", "COUNTYNM", "DIA", "VOLBFNET")]

#rename columns to match "inat_trees" and "USDA_trees"
inat_trees <- inat_trees %>%
  rename(
    species = SPECIES,
    common_name = COMMON_NAME,
    county_name = county_names
  )

USDA_trees <- USDA_trees %>%
  rename(
    latitude = LAT,
    longitude = LON,
    species = SPECIES,
    common_name = COMMON_NAME,
    county_name = COUNTYNM
  )
#remove +0100 from all rows in the created_at column
inat_trees$created_at <- sub("\\+0100", "", inat_trees$created_at)

#round each value in VOLBFNET to 1 decimal place
USDA_trees$VOLBFNET <- round(USDA_trees$VOLBFNET, 1)

#combine the two dataframes
combined_trees <- rbind(USDA_trees, inat_trees)
#change the variable name
Arborist_Elite_inventory <- combined_trees

#rename column "created_at" in "Arborist_Elite_inventory
Arborist_Elite_inventory <- Arborist_Elite_inventory %>%
  rename(harvested = created_at)
#order rows by "harvested" in descending order
Arborist_Elite_inventory <- Arborist_Elite_inventory[order(Arborist_Elite_inventory$harvested, decreasing = FALSE), ]

#create the "Tree_ID" column with sequential numbers
Arborist_Elite_inventory$Tree_ID <- seq(1, nrow(Arborist_Elite_inventory))

#move "Tree_ID" to the first column
Arborist_Elite_inventory <- Arborist_Elite_inventory[, c("Tree_ID", setdiff(names(Arborist_Elite_inventory), "Tree_ID"))]

#create a lookup table for the species codes
species_lookup <- data.frame(
  species = c("rigida", "virginiana", "echinata", "strobus", "resinosa", "serotina", "taeda", "sylvestris"),
  code = c("SP01", "SP02", "SP03", "SP04", "SP05", "SP06", "SP07", "SP08")
)

#replace species with the corresponding codes
Arborist_Elite_inventory <- Arborist_Elite_inventory %>%
  left_join(species_lookup, by = "species") %>% # Join the lookup table
  mutate(species = code) %>% # Replace species with codes
  select(-code) # Remove the temporary 'code' column

#create a lookup table for the county_name codes
county_lookup <- data.frame(
  county_name = c("Ocean", "Atlantic", "Cumberland", "Burlington", "Cape May", "Gloucester", "Camden", 
                  "Hunterdon", "Monmouth", "Passaic", "Sussex", "Middlesex", "Salem", "Warren", "Somerset", 
                  "Bergen", "Morris", "Mercer", "Union", "Essex", "Hudson"),
  code = c("Co01", "Co02", "Co03", "Co04", "Co05", "Co06", "Co07", "Co08", "Co09", "Co10", "Co11", "Co12", 
           "Co13", "Co14", "Co15", "Co16", "Co17", "Co18", "Co19", "Co20", "Co21")
)

#replace county_name with the corresponding codes
Arborist_Elite_inventory <- Arborist_Elite_inventory %>%
  left_join(county_lookup, by = "county_name") %>% # Join the lookup table
  mutate(county_name = code) %>% # Replace county_name with codes
  select(-code) # Remove the temporary 'code' column

#remove column "common_name" from "Arborist_Elite_inventory
Arborist_Elite_inventory<-Arborist_Elite_inventory%>%
  select(-common_name)

#save the dataframe as a CSV file
write.csv(Arborist_Elite_inventory, "Arborist_Elite_inventory.csv", row.names = FALSE)
