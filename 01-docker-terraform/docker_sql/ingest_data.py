#!/usr/bin/env python
# coding: utf-8
import os
import argparse
import pandas as pd
import pyarrow.parquet as pq
import sqlalchemy as db

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    database_name = params.database_name
    table_name = params.table_name
    url = params.url
    parquet_file = 'yellow_tripdata_2024-01.parquet'
    csv_file = 'yellow_tripdata_2024-01.csv'

    print("Downloading the Parquet file...")
    os.system(f"wget {url} -O {parquet_file}")

    print("Converting the Parquet file to CSV...")
    parquet_table = pq.read_table(parquet_file)
    parquet_table.to_pandas().to_csv(csv_file, index=False)
    print(f"Parquet file converted to CSV: {csv_file}")


    engine = db.create_engine(f'postgresql://{user}:{password}@{host}:{port}/{database_name}')

    print("Reading the CSV file in chunks...")
    df_itr = pd.read_csv(csv_file, iterator=True, chunksize=100000)

    # Process the first chunk to create the table
    df = next(df_itr)
    # Convert datetime columns
    df['tpep_pickup_datetime'] = pd.to_datetime(df['tpep_pickup_datetime'])
    df['tpep_dropoff_datetime'] = pd.to_datetime(df['tpep_dropoff_datetime'])

    # Create the table and insert the first chunk
    df.head(0).to_sql(name=table_name, con=engine, if_exists='replace', index=False)
    df.to_sql(name=table_name, con=engine, if_exists='append', index=False)

    # Process and insert remaining chunks
    for i, df in enumerate(df_itr):
        df['tpep_pickup_datetime'] = pd.to_datetime(df['tpep_pickup_datetime'])
        df['tpep_dropoff_datetime'] = pd.to_datetime(df['tpep_dropoff_datetime'])
        df.to_sql(name=table_name, con=engine, if_exists='append', index=False)
        print(f"Chunk {i+1} inserted successfully.")

    print("Data ingestion completed successfully.")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Ingest CSV data to PostgreSQL")
    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--database_name', help='database name in postgres')
    parser.add_argument('--table_name', help='Table name for postgres')
    parser.add_argument('--url', help='URL for the Parquet file')

    args = parser.parse_args()

    main(args)
