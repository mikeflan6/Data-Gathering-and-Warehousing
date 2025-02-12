# Michael Flanagan
# Data Warehouse
# Ass 01_02

#Import pandas library and name it "pd"
import pandas as pd
#Import matplotlib.pyplot and name it "plt"
import matplotlib.pyplot as plt
#Import os module to interact with underlying operating system
import os
#Change directory to "C:\\Users\\mikef\\Documents\\ML_Fundamentals"
os.chdir("C:\\Users\\mikef\\Documents\\Data_Warehouse")
#Read in 'NJ_TREE.csv' and name it "FIA_TREE"
FIA_TREE=pd.read_csv('NJ_TREE.csv')
#Read in 'iNAT_TREE.csv' and name it "iNAT_TREE"
iNAT_TREE=pd.read_csv('iNAT_TREE.csv')

#FIA_TREE had 194 columns, most of which were empty. 
print(FIA_TREE.columns)
#Consolidated df to 6 columns
FIA_TREE_select_columns=['CN','PLT_CN','INVYR','COUNTYCD','SPCD','DIA']
FIA_TREE=FIA_TREE[FIA_TREE_select_columns]

#FIA_TREE now has 6 columns and 74,819 rows
print(FIA_TREE.info())

#Consolidate df to rows containing "Pine Trees"
#SPCD:
    #Pitch Pine 126
    #Shortleaf Pine 110
    #Eastern White Pine 129
    #Virginia Pine 132
    #Red Pine 125
    #Scotch Pine 130
    #Pond Pine 128
    #Loblolly Pine 131
    #Austrian Pine 136 
#Create variable "filter_elements" assign SPCD related to pine trees
filter_elements = [126, 110, 129, 132, 125, 130, 128, 131, 136]

#Filter df to rows containing filter_element SPCD
#FIA_TREE now has 6 columns and 17,431 rows
FIA_TREE = FIA_TREE[FIA_TREE['SPCD'].isin(filter_elements)]

#Replaces numeric values with labels
spcd_labels = {
    126: "Pitch Pine",
    110: "Shortleaf Pine",
    129: "Eastern White Pine",
    132: "Virginia Pine",
    125: "Red Pine",
    130: "Scotch Pine",
    128: "Pond Pine",
    131: "Loblolly Pine",
    136: "Austrian Pine"
}

#Replace the SPCD column values with the corresponding labels
FIA_TREE['SPCD'] = FIA_TREE['SPCD'].map(spcd_labels)

#Gets the counts of each unique SPCD value
spcd_counts = FIA_TREE['SPCD'].value_counts()

#Initiates a new figure and sets size dimensions
plt.figure(figsize=(10, 6))
#Creates bar graph using "spcd_counts"
bar_plot = spcd_counts.plot(kind='bar')
#Sets title of plot
plt.title('Quantity of Each Pine Tree Common Name in NJ')
#Sets x-axis title of plot
plt.xlabel('Pine Tree Species')
#Sets y-axis title of plot
plt.ylabel('Count')
#Rotates x-axis labels by 45 degrees
plt.xticks(rotation=45)

#For loop iterates over values in "spcd_counts
#Horizontally centers text on bar
#Vertically aligns test bottom to top of bar
for index, value in enumerate(spcd_counts):
    plt.text(index, value, str(value), ha='center', va='bottom')
#Ensures everything fits without overlapping
plt.tight_layout()
#Displays plot
plt.show()

#iNAT_TREE had 40 columns, most of which are useless. 
print(iNAT_TREE.columns)

#FIA_TREE has 8,907 rows
print(iNAT_TREE.info())

#Filter df "iNAT_TREE" to rows containing "research" in column "quality_grade"
filter_element = ['research']
#iNAT_TREE now has 40 columns and 3,844 rows
iNAT_TREE = iNAT_TREE[iNAT_TREE['quality_grade'].isin(filter_element)]

#Select columns from original df. Reassign variable "iNAT_TREE" with select columns
#Consolidated df to 11 columns and 3,844 rows
iNAT_TREE_select_columns=['observed_on','time_observed_at','user_id','user_name','created_at','updated_at','latitude','longitude','species_guess','scientific_name','common_name']
iNAT_TREE=iNAT_TREE[iNAT_TREE_select_columns]

#Count the number of occurrences for each unique value in the 'common_name' column
common_name_counts = iNAT_TREE['common_name'].value_counts()

#Initiates a new figure and sets size dimensions
plt.figure(figsize=(10, 6))
#Creates bar graph using "common_name_counts"
bar_plot = common_name_counts.plot(kind='bar')
#Sets title of plot
plt.title('Quantity of Each Pine Tree Species in NJ')
#Sets x-axis title of plot
plt.xlabel('Pine Tree Common Name')
#Sets y-axis title of plot
plt.ylabel('Count')
#Rotates x-axis labels by 45 degrees
plt.xticks(rotation=45)

#For loop iterates over values in "common_name_counts"
#Horizontally centers text on bar
#Vertically aligns text bottom to top of bar
for index, value in enumerate(common_name_counts):
    plt.text(index, value, str(value), ha='center', va='bottom')
#Ensures everything fits without overlapping
plt.tight_layout()
#Displays plot
plt.show()




