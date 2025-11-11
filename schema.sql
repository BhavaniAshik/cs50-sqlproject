

-- Represent Customer Table

CREATE TABLE IF NOT EXISTS "Customer" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "phone" TEXT,
	PRIMARY KEY ("id")
);

-- Represent Categories Table

CREATE TABLE IF NOT EXISTS "Categories" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
	PRIMARY KEY ("id")
);

-- Represent Prodcut Table

CREATE TABLE IF NOT EXISTS "Product" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "price" REAL NOT NULL CHECK("price" > 0),
    "category_id" INTEGER NOT NULL,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("category_id") REFERENCES "Categories"("id")
);

-- Represent Order Table

CREATE TABLE IF NOT EXISTS "Order" (
    "id" INTEGER,
    "date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "customer_id" INTEGER NOT NULL,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "Customer"("id")
);

-- Represent Order_items Table

CREATE TABLE IF NOT EXISTS "Order_items" (
    "id" INTEGER,
    "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
    "price" REAL NOT NULL CHECK("price" > 0),
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("order_id") REFERENCES "Order"("id"),
    FOREIGN KEY ("product_id") REFERENCES "Product"("id")
);

-- Represent Rating Table

CREATE TABLE IF NOT EXISTS "Rating" (
    "id" INTEGER,
    "rating" INTEGER NOT NULL CHECK("rating" BETWEEN 1 AND 5),
    "orderitem_id" INTEGER NOT NULL UNIQUE,
    "customer_id" INTEGER NOT NULL,
	PRIMARY KEY ("id"),
    FOREIGN KEY ("orderitem_id") REFERENCES "Order_items"("id"),
    FOREIGN KEY ("customer_id") REFERENCES "Customer"("id")
);


-- Create Indexes to speed common searches

CREATE INDEX "idx_customer_first_name" ON "Customer" ("first_name");

CREATE INDEX "idx_customer_last_name" ON "Customer" ("last_name");

CREATE INDEX "idx_product_name" ON "Product" ("name");

CREATE INDEX "idx_category_name" ON "Categories" ("name");

CREATE INDEX "idx_order_customer_id" ON "Order" ("customer_id");

CREATE INDEX "idx_orderitems_product_id" ON "Order_items" ("product_id");

CREATE INDEX "idx_orderitems_order_id" ON "Order_items" ("order_id");

CREATE INDEX "idx_order_date" ON "Order" ("date");

CREATE INDEX "idx_high_rating" ON "Rating" ("rating")
WHERE "rating" > 3;


-- Represent view Product with Category_name

CREATE VIEW IF NOT EXISTS "Product_category_view" AS
SELECT
 "Product"."id" AS "Product_id",
 "Product"."name" AS "Product_name", 
 "Categories"."name" AS "Category_name"
FROM "Product"
JOIN "Categories" ON "Product"."category_id" = "Categories"."id"
ORDER BY "Product_name", "Category_name"
;

