--1. Get all customers and their addresses.
SELECT "first_name", "last_name", "addresses"."street", "addresses"."city", "addresses"."city", "addresses"."state", 
"addresses"."zip", "addresses"."address_type" FROM "customers"
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id";

--2. Get all orders and their line items (orders, quantity and product).
SELECT "order_date", "line_items"."quantity", "products"."description" FROM "orders"
JOIN "line_items" ON "line_items"."order_id" = "orders"."id"
JOIN "products" ON "products"."id" = "line_items"."product_id";

--3. Which warehouses have cheetos?
SELECT "warehouse", "P"."description" FROM "warehouse"
JOIN "warehouse_product" AS "WP" ON "WP"."warehouse_id" = "warehouse"."id"
JOIN "products" AS "P" ON "P"."id" = "WP"."product_id"
WHERE "P"."description" = 'cheetos';

--4. Which warehouses have diet pepsi?
SELECT "warehouse", "P"."description" FROM "warehouse"
JOIN "warehouse_product" AS "WP" ON "WP"."warehouse_id" = "warehouse"."id"
JOIN "products" AS "P" ON "P"."id" = "WP"."product_id"
WHERE "P"."description" = 'diet pepsi';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT "first_name", "last_name", COUNT("orders"."address_id") FROM "customers"
JOIN "addresses" ON "addresses"."customer_id" = "customers"."id"
JOIN "orders" ON "orders"."address_id" = "addresses"."id"
GROUP BY "customers"."last_name", "customers"."first_name"
ORDER BY "customers"."last_name";

--6. How many customers do we have?
--if we count all customers regardless if they have an order
SELECT COUNT(*) FROM customers;
--if we count only those customers that have an active order
SELECT COUNT(DISTINCT "addresses"."customer_id") FROM "addresses"
JOIN "orders" ON "orders"."address_id" = "addresses"."id";

--7. How many products do we carry?
SELECT COUNT(*) FROM "products";

--8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM("on_hand") FROM "warehouse_product" AS "WP"
JOIN "products" ON "products"."id" = "WP"."product_id"
WHERE "products"."description" = 'diet pepsi';

------STRETCH-------
--9. How much was the total cost for each order?
SELECT SUM("LI"."quantity" * "products"."unit_price"), "orders"."id", "orders"."order_date" FROM "line_items" AS "LI"
JOIN "orders" ON "orders"."id" = "LI"."order_id"
JOIN "products" ON "products"."id" = "LI"."product_id"
GROUP BY "orders"."id"
ORDER BY "orders"."id";