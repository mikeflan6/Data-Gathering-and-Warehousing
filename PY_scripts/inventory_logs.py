import pandas as pd
from datetime import timedelta

# Load the CSV file
df = pd.read_csv(r"C:\Users\amora\Documents\Python Scripts\DW\Final\Arborist_Elite_inventory.csv", parse_dates=['harvested'])

# Sort for consistent grouping
df.sort_values(by=["County_ID", "Species_ID", "harvested"], inplace=True)

# Initialize new columns
df["sales_id"] = pd.NA
df["Sales_Date"] = pd.NaT

sales_id_counter = 1

# Group and process
for _, group in df.groupby(["County_ID", "Species_ID"]):
    group = group.sort_values("harvested")
    indices = group.index.tolist()
    
    for i in range(0, len(indices), 25):
        batch_indices = indices[i:i+25]

        if len(batch_indices) < 25:
            continue  # Skip incomplete batches

        max_harvested = df.loc[batch_indices, "harvested"].max()
        sales_date = max_harvested + timedelta(days=10)

        df.loc[batch_indices, "sales_id"] = sales_id_counter
        df.loc[batch_indices, "Sales_Date"] = sales_date

        sales_id_counter += 1

# Drop rows without a sale
df = df.dropna(subset=["sales_id"])

# Define the price lookup table
price_lookup = {
    "SP01": 52.50,
    "SP02": 100.80,
    "SP03": 101.85,
    "SP04": 35.00,
    "SP05": 200.64,
    "SP06": 332.65,
    "SP07": 174.16,
    "SP08": 662.99
}

# Map prices
df["price_bdft"] = df["Species_ID"].map(price_lookup)

# Calculate sales price
df["sales_price"] = round(df["VOLBFNET"] * df["price_bdft"],2)

# Save final result
df.to_csv("grouped_sales_output.csv", index=False)
