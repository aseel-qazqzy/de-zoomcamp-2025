import pandas as pd 

parquet_file = "yellow_tripdata_2024-01.parquet"
csv_file = "yellow_tripdata_2024-01.csv"

# convert 
df = pd.read_parquet(parquet_file)
df.to_csv(csv_file, index=False)

print(f"Converted {parquet_file} to {csv_file}")



