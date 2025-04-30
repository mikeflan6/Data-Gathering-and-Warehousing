#import packages
import matplotlib.pyplot as plt
from matplotlib.ticker import ScalarFormatter
import matplotlib.ticker as ticker
import seaborn as sns
import pandas as pd


#Load in data
df1 = pd.read_csv(r'C:\Users\amora\Documents\Python Scripts\DW\Final\Results\Q1.csv')
df2 = pd.read_csv(r'C:\Users\amora\Documents\Python Scripts\DW\Final\Results\Q3.csv')
df3 = pd.read_csv(r'C:\Users\amora\Documents\Python Scripts\DW\Final\Results\Q2.csv')

# Sort the data by sales_year 
df1 = df1.sort_values('sales_year')

# Extract sales data
x1 = df1['sales_year']
y1 = df1['Total_Sales']
y_thousands = y1 / 1000

# Create line plot
plt.plot(x1, y_thousands, label="Sales over the Years", marker='o')

# Format y-axis to plain numbers with commas
ax = plt.gca()
ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, pos: f'{x:,.0f}'))

# Labels and title
plt.xlabel('Year')
plt.ylabel('Sales (in Thousands)')
plt.title('Sales Over the Years')
plt.grid(True)
plt.tight_layout()
plt.show()

#################################################################################################################

# 1. Melt the DataFrame
df_melted = df2.melt(id_vars=['County_ID'], 
                    value_vars=['SP01', 'SP02', 'SP03', 'SP04', 'SP05', 'SP06', 'SP07', 'SP08'],
                    var_name='SP', 
                    value_name='Value')

# 2. Pivot: County_ID as index, SP as columns
heatmap_data = df_melted.pivot(index='County_ID', columns='SP', values='Value')

# 3. Plot the heatmap
plt.figure(figsize=(10, 8))
sns.heatmap(heatmap_data, cmap='viridis', annot=True, fmt=".1f")
plt.title("Heatmap of SP Values per County")
plt.xlabel("SP")
plt.ylabel("County ID")
plt.tight_layout()
plt.show()

###################################################################################################################

new_row = {
    'State': 'Virginia',
    'sales_year': 2024,
    'sales_count': 0,
    'yearly_sales': 0
}

df3 = pd.concat([df3, pd.DataFrame([new_row])], ignore_index=True)


df3['sales_year'] = df3['sales_year'].astype(int).astype(str)
#set x and y values
x3 = df3['sales_year'].astype(str)
y3 = df3['yearly_sales']

state_abbr = {
    'California': 'CA',
    'Florida': 'FL',
    'Virginia': 'VA',
}

df3['State_Abbr'] = df3['State'].map(state_abbr)

# Create line plot


# Plot one line per state
for state, group in df3.groupby('State_Abbr'):
    group = group.sort_values('sales_year')
    plt.plot(group['sales_year'], group['yearly_sales'], marker='o', label=state)

# Format y-axis to plain numbers with commas
ax = plt.gca()
ax.yaxis.set_major_formatter(ticker.FuncFormatter(lambda x, pos: f'{x:,.0f}'))

# Labels and title
plt.xlabel('Year')
plt.ylabel('Sales (in Thousands)')
plt.title('Sales Over the Years')
plt.grid(True)
plt.legend(title='State', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.tight_layout()
plt.show()
