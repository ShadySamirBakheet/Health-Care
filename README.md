# Health Care app

* app for follow patient healthy
* develop by flutter and serverpod

## Requeriment

* Flutter [https://flutter.dev](https://flutter.dev). for app
* Serverpod [https://docs.serverpod.dev](https://docs.serverpod.dev). for server 
* Docker [https://www.docker.com](https://www.docker.com/products/docker-desktop/). for server 
* Ngrok [https://ngrok.com](https://ngrok.com). for run server from network

## App

### health care flutter

A new Flutter project with Serverpod.

## Getting Started

This project is a starting point for a Flutter application that is using
Serverpod.

To run the project, first make sure that the server is running, then do:

    flutter run
  
## server

### health cares erver

This is the starting point for your Serverpod server.

To run your server, you first need to start Postgres and Redis. It's easiest to do with Docker.

    docker compose up --build --detach

Then you can start the Serverpod server.

    dart bin/main.dart

When you are finished, you can shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis.

    docker compose stop
    
You can start the Serverpod server from network.

    ngrok http 8080
