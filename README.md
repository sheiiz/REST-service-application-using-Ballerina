# REST API service application for a resturant using Ballerina
This project is a REST API service for managing food items for a restaurant, built using Ballerina. The service demonstrate the CRUD operations in ballerina including endpoints to get all food items, add new food items, update food items and delete food items.

`This project is developed under the course module CO528 - Applied Software Architecture`

## Prerequisites

- [Ballerina](https://ballerina.io/downloads/)
- [Docker](https://www.docker.com/get-started)
- [Git](https://git-scm.com/)

## Getting Started

1. Clone the Repository
```sh
git clone <repository-url>
```

## Running the Service Locally
1. **Navigate to the project directory**
```sh
cd restaurant_service
```

2. **Run the Ballerina service**
```sh
bal run
```


## Dockerizing the Application
1. **Build the Docker image:**
```sh
bal build
```

2. **Run the Docker container:**
```sh
docker run -d -p 9090:9090 co528_shehan/ballerina_resturant:v0.1.0
```

## Test the Endpoints
Use `curl` or Postman to test the endpoints. The service will be running on `http://localhost:9090`
```sh
curl -X GET http://localhost:9090/restaurant/food_items

curl -X POST http://localhost:9090/restaurant/food_items -H "Content-Type: application/json" -d '{"id": 3, "name": "Pasta", "available_quantity": 15, "price": 10.99, "category": "Main Course"}'

curl -X PUT http://localhost:9090/restaurant/food_items -H "Content-Type: application/json" -d '{"id": 1, "name": "Pizza", "available_quantity": 8, "price": 12.99, "category": "Main Course"}'

curl -X DELETE http://localhost:9090/restaurant/food_items/{id}
```
