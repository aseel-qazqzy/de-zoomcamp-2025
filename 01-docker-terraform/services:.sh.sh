services:
  postgres:
    image: postgres:14
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    volumes:
      - postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      interval: 5s
      retries: 5
    restart: always


## run pgdatabase conatiner
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v "$(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data" \
  -p 5433:5432 \
  postgres:14

## run pgadmin conatiner
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  dpage/pgadmin4


## create a docker netweok so both conatiners can communicate with each other, the default is a bridge netwrok 
## and it is used if the both conatiners are in the same host. 
docker network create pg-network

# Modify the continers parameters , --name so you can use it in the other conatiner
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v "$(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data" \
  -p 5433:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:14

# Modify the continers parameters , --name is not important since no other app will connect to it
  docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network\
  --name pg-database \
  dpage/pgadmin4

# Run the script with Docker - script to load the data and save it to our pgdbconatiners

URL="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet"

docker run -it \
    --network=pg-network \
    taxi_ingest:v002 \
    --user=root \
    --password=root \
    --host=pg-database \
    --port=5432 \
    --database_name=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL} 
  taxi_ingest:v002




# python 
python ingest_data.py \
    --user root \
    --password root \
    --host localhost \
    --port 5433 \
    --database_name ny_taxi \
    --table_name yellow_taxi_trips \
    --url   https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet
