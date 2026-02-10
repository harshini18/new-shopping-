#!/bin/bash

# Configuration
MAVEN_BIN="/Users/venkatramanareddyp/Documents/Online Retail Shopping/tools/apache-maven-3.9.6/bin"
NODE_BIN="/Users/venkatramanareddyp/Downloads/Online-Retail-Shopping-main/Online-Retail-Shopping-main/node-v20.11.0-darwin-x64/bin"
PROJECT_ROOT="/Users/venkatramanareddyp/Downloads/new-shopping--main/Online-Retail-Shopping-Application-main"
LOG_DIR="$PROJECT_ROOT/logs"

# Add tools to PATH
export PATH="$MAVEN_BIN:$NODE_BIN:$PATH"

# Create logs directory
mkdir -p "$LOG_DIR"

# Function to run service
run_service() {
    local service_name="$1"
    local service_dir="$2"
    local command="$3"
    local log_file="$LOG_DIR/${service_name}.log"

    echo "Starting $service_name..."
    cd "$PROJECT_ROOT/$service_dir"
    nohup $command > "$log_file" 2>&1 &
    echo "PID: $!"
}

echo "Starting generic retail application services..."

# 1. Eureka Server
run_service "Eureka Server" "eureka-server" "mvn spring-boot:run"

echo "Waiting for Eureka to initialize (20s)..."
sleep 20

# 2. API Gateway
run_service "API Gateway" "api-gateway" "mvn spring-boot:run"
echo "Waiting for API Gateway (10s)..."
sleep 10

# 3. Microservices
run_service "User Service" "user-service" "mvn spring-boot:run"
run_service "Product Service" "product-service" "mvn spring-boot:run"
run_service "Inventory Service" "inventory-service" "mvn spring-boot:run"
run_service "Cart Service" "cart-service" "mvn spring-boot:run"
run_service "Payment Service" "payment-service" "mvn spring-boot:run"
run_service "Order Service" "order-service" "mvn spring-boot:run"
run_service "Notification Service" "notification-service" "mvn spring-boot:run"

echo "Waiting for microservices to initialize (30s)..."
sleep 30

# 4. Frontend
echo "Starting Frontend..."
cd "$PROJECT_ROOT/retail-frontend"
# Check if node_modules exists, if not install
if [ ! -d "node_modules" ]; then
    echo "Installing frontend dependencies..."
    npm install
fi
nohup npm run dev > "$LOG_DIR/frontend.log" 2>&1 &
echo "Frontend PID: $!"

echo "All services started. Logs are in $LOG_DIR"
