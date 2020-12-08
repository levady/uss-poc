# USS POC

This is a POC for estimating USS rides waiting time.

## Prerequisites

- docker
- docker compose

## Setup

1. Install `docker` and `docker-compose` by following the instruction here https://docs.docker.com/get-docker/
2. Prepare `.env` file. Copy the file `.env.sample` to be `.env` and replace the username and passwords required to run the application
3. Prepare DB by running this docker command. Running this will also seeds some data into the development DB

        docker-compose run app rails db:setup
4. Run `docker-compose up` to start all the containers

## Postman

1. Import `USS POC.postman_collection.json` into your postman collection. The file is in the root of the project
2. Import `USS POC ENV.postman_enviroment.json` into the postman environments manager. The file is in the root of the project
3. Select USS POC ENV as the environment configuration
4. Start testing the APIs by selecting them from the USS POC collection

## Running Test

Run `docker-compose run app rspec -fd` for running the RSpec test suite
