import pandas as pd
from datetime import timedelta

# Load the CSV file
df = pd.read_csv(r"C:\Users\amora\Documents\Python Scripts\DW\Final\inventory_logs.csv", parse_dates=['harvested'])

# Sort for consistent grouping
df.sort_values(by=["sales_id",], inplace=True)

grouped_df = df.groupby(["sales_id", "Sales_Date"])["sales_price"].sum().reset_index()



grouped_df.to_csv("sales.csv", index=False) 



