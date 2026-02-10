#!/bin/bash
echo "Killing all java and node processes..."

# Kill by name pattern from maven
pkill -f "eureka-server"
pkill -f "api-gateway"
pkill -f "user-service"
pkill -f "product-service"
pkill -f "inventory-service"
pkill -f "order-service"
pkill -f "cart-service"
pkill -f "payment-service"
pkill -f "notification-service"

# Kill generic java if running as jar (fallback)
# Careful with this one, maybe too broad? I'll stick to ports.

# Kill by ports
echo "Killing processes on ports..."
lsof -ti:8761 | xargs kill -9 2>/dev/null
lsof -ti:8222 | xargs kill -9 2>/dev/null
lsof -ti:8081 | xargs kill -9 2>/dev/null # User
lsof -ti:8082 | xargs kill -9 2>/dev/null # Product
lsof -ti:8083 | xargs kill -9 2>/dev/null # Inventory
lsof -ti:8084 | xargs kill -9 2>/dev/null # Cart?
lsof -ti:8085 | xargs kill -9 2>/dev/null # Payment?
lsof -ti:8086 | xargs kill -9 2>/dev/null # Order?
lsof -ti:8087 | xargs kill -9 2>/dev/null # Notification?

# Kill Frontend
pkill -f "vite"
lsof -ti:5173 | xargs kill -9 2>/dev/null
lsof -ti:3000 | xargs kill -9 2>/dev/null

echo "All services killed."
