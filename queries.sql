-- Add new Customers

INSERT INTO "Customer" ("first_name", "last_name", "email", "phone") 
VALUES
('Amit', 'Sharma', 'amit.sharma@example.com', '+919876543210'),
('Priya', 'Rao', 'priya.rao@example.com', '+919845612378'),
('Kiran', 'Patel', 'kiran.patel@example.com', '+919812345678'),
('Suresh', 'Kumar', 'suresh.kumar@example.com', '+919987654321'),
('Neha', 'Verma', 'neha.verma@example.com', '+919823456789'),
('Ravi', 'Iyer', 'ravi.iyer@example.com', '+919934567890'),
('Meena', 'Nair', 'meena.nair@example.com', '+919912345678'),
('Anil', 'Reddy', 'anil.reddy@example.com', '+919967890123'),
('Divya', 'Joshi', 'divya.joshi@example.com', '+919945612345'),
('Rahul', 'Das', 'rahul.das@example.com', '+919876123456')
;

-- Add new Categories

INSERT INTO "Categories" ("name") 
VALUES
('Electronics'),
('Home Appliances'),
('Clothing'),
('Footwear'),
('Books'),
('Groceries'),
('Beauty & Personal Care'),
('Sports & Fitness'),
('Toys & Games'),
('Furniture')
;

-- Add new Products

INSERT INTO "Product" ("name", "price", "category_id") 
VALUES
('Samsung Galaxy S23', 74999.00, 1),
('HP Pavilion Laptop', 65990.00, 1),
('LG Washing Machine', 34990.00, 2),
('Men Cotton Shirt', 1299.00, 3),
('Nike Running Shoes', 4999.00, 4),
('Cricket Bat', 2999.00, 8),
('Yoga Mat', 799.00, 8),
('Chetan Bhagat Novel', 299.00, 5),
('Dove Shampoo 650ml', 449.00, 7),
('Wooden Study Table', 4999.00, 10),
('Lego Building Set', 2499.00, 9),
('Gel Pen Pack', 99.00, 6)
;

-- Add new Order details

INSERT INTO "Order" ("date", "customer_id") 
VALUES
('2023-01-15', 1),
('2023-03-22', 2),
('2023-07-11', 3),
('2023-11-05', 4),
('2024-02-19', 5),
('2024-04-10', 6),
('2024-06-25', 7),
('2024-09-14', 8),
('2024-12-02', 9),
('2025-03-16', 10),
('2024-03-17', 1),
('2025-06-22', 5)
;

-- Add new Order_items

INSERT INTO "Order_items" ("quantity", "price", "order_id", "product_id")
VALUES
(1, 74999.00, 1, 1),
(1, 65990.00, 2, 2),
(1, 34990.00, 3, 3),
(2, 1299.00, 3, 4),
(1, 4999.00, 4, 5),
(1, 2999.00, 5, 6),
(2, 799.00, 6, 7),
(1, 299.00, 7, 8),
(1, 449.00, 8, 9),
(1, 4999.00, 9, 10),
(1, 2499.00, 10, 11),
(3, 99.00, 10, 12),
(2, 4999.00, 4, 4)
;

-- Add new Ratings

INSERT INTO "Rating" ("rating", "orderitem_id", "customer_id") 
VALUES
(5, 1, 1),
(4, 2, 2),
(5, 3, 3),
(3, 4, 3),
(4, 5, 4),
(5, 6, 5),
(2, 7, 6),
(4, 8, 7),
(5, 9, 8),
(4, 10, 9),
(5, 11, 10)
;


-- Find total orders by each customer

SELECT 
    "first_name" ||' '|| "last_name" AS "customer_name",
    COUNT("order_id") AS "total_orders"
FROM "Customer" 
LEFT JOIN "Order" ON "Customer"."id" = "Order"."customer_id"
GROUP BY "customer"."id"
;

-- Find Top 5 rating products

SELECT 
    "name" , ROUND(AVG("rating"),2) AS avg_rating
	FROM "Product"
JOIN "Order_items" ON "Product"."id" = "Order_items"."product_id"
JOIN "Rating" ON "Order_items"."id" = "Rating"."orderitem_id"
GROUP BY "name"
ORDER BY "avg_rating" DESC LIMIT 5
;

-- Find total quantity of the given product
SELECT 
    "product"."name",SUM("Order_items"."quantity") as "totalquantity" 
FROM "Product"
JOIN "Order_items" ON "Product"."id" = "Order_items"."product_id"
WHERE "Product"."name"='Men Cotton Shirt'
GROUP BY "product"."id"
;

-- Find total sales for the given year

SELECT
    SUM ("Order_items"."quantity" * "Order_items"."price") AS "Yearly_totalsales" 
FROM "Order"
JOIN "Order_items" ON "Order"."id" = "Order_items"."order_id"
WHERE "Order"."date" BETWEEN '2023-01-01' AND '2023-12-31' 
;


-- Delete the rating for the given ID

DELETE FROM "Rating"
WHERE "id" = 8;

-- Find product details for given category using VIEW

SELECT * FROM "Product_category_view"
WHERE "Category_name" = 'Sports & Fitness'
;