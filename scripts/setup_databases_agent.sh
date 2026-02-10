#!/bin/bash

# Configuration
DB_USER="root"
DB_PASS="Deepika@18"

echo "Setting up databases..."

# Create databases
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS retail_user_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS product_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS retail_inventory_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS retail_cart_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS order_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS retail_payment_db;"
mysql -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS retail_notification_db;"

echo "Databases created."

# Create Admin User
echo "Creating Admin User..."
mysql -u "$DB_USER" -p"$DB_PASS" retail_user_db -e "INSERT IGNORE INTO users (email, password, first_name, last_name, role, created_at, updated_at) VALUES ('admin@retail.com', '\$2a\$10\$Ukg9xZBqhVY.VggAvDWfkuaC9Rpaunnel5E/KPuSjKy3DsIsaEpgW', 'Admin', 'User', 'ADMIN', NOW(), NOW());"

echo "Admin User created (if not exists)."
echo "Username: admin@retail.com"
echo "Password: admin123"

