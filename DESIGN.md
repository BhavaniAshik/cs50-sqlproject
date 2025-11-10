# Design Document

By Bhavani B R

Youtube link [CS50 Final Project Video (YouTube)] : (https://youtu.be/TZQCXpnnVn4)

Video overview: ![Video](Video.mp4)


## Scope

The database for CS50 SQL includes all entities necessary to facilitate managing customer, products and orders,and allow customers to rate products only after purchasing them and it helps to analyse the sales and prodcut reviews efficiently. 

Included in Scope:

* Customer, including basic identifying information
* Category, including category name which groups product into logical categories
* Product, including details such as Name and price
* Order, which includes detail of each purchase made by customer
* Order_items, specifying the products and quantities within each order
* Rating, enabling the customer to rate products only after purchase

Out of scope are elements like Payments, shipping details, User authentication.

## Functional Requirements

This database will support:

* CRUD operations for Customers, Products and Categories
* Tracking all customer orders and ordered items
* Allowing ratings only for purchased product


## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

The database includes the following entities:

#### customer

The `customer` table includes:

* `id`, which specifies the unique ID for the customer as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the customer's first name as `TEXT`, given `TEXT` is appropriate for name fields.`NOT NULL` to ensure column must always have value.
* `last_name`, which specifies the customer's last name. `TEXT` is used for the same reason as `first_name`.
* `email`, which specifies the customer email_id as `TEXT`. A `UNIQUE` constraint to prevent duplicates.
* `phone`, which specifies optional contact number as `TEXT` Since phone number may include symbols(+91..).

#### categories

The `categories` table includes:

* `id`, which specifies the unique ID for the product category as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies name of the product category as `TEXT`.`

All columns in the `categories` table are required and hence should have the `NOT NULL` constraint applied. No other constraints are necessary.


#### product

The `product` table includes:

* `id`, which specifies the unique ID for the products as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `name`, which specifies name of products as `TEXT`.
* `price`, which is the price of the product.This column is represented with a `REAL` type affinity, which supports decimal value for rupee pricing.
* `category_id`, which is the ID of the categories as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `categories` table to ensure data integrity.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.The `price` column has an additional constraint to check if its value is greater than 0 , given that this is prevents entering zero or negative prices.

#### order

The `order` table includes:

* `id`, which specifies the unique ID for the orders made by the customer as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `date`, which is the date of the order made by the customer as an `DATETIME`constraint applied. The default value for the `date` attribute is the current timestamp, as denoted by `DEFAULT CURRENT_TIMESTAMP`.

* `customer_id`, which is the ID of the customer as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `customer` table to ensure data integrity.

#### order_items

The `order_items` table includes:

* `id`, which specifies the unique ID for the order items as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `quantity`, which is the quantity of the product ordered by the customer as an `INTEGER`.
* `price`, which is the price of the product.This column is represented with a `REAL` type affinity, which supports decimal value for rupee pricing. 
* `order_id`, which is the ID of the order made by customer as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `order` table to ensure data integrity.
* `product_id`, which is the ID of the products as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `product` table to ensure data integrity.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.The `price`and `quantity` column has an additional constraint to check if its value is greater than 0 , given that this is prevents entering zero or negative prices and quntity.

#### Rating

The `Rating` table includes:

* `id`, which specifies the unique ID for the Ratings as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `rating`, which specifies the ratings of the product which is purchased by the customer as an `INTEGER`. 
* `orderitem_id`, which is the ID of the order items as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `order_items` table to ensure data integrity.
* `customer_id`, which is the ID of the customer who given the ratings to their purchased product as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `customer` table to ensure data integrity.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.The `rating`column has an additional constraint to check if its value is between 1 and 5 , given that this is limits the ratings to a 1-5 scale only.


### Relationships

The below entity relationship diagram describes the relationships among the entities in the database.

![ER Diagram](diagram.png)

As detailed by the diagram:

* One customer can place many orders, but each order belongs to only one customer.
* An order can contain multiple products, but each order item belongs to only one order.
* A product can appear in many order items, but each order item referes to only one product.
* One category can have many products, but each product belongs to only one category.
* Each order item can have 0 or 1 rating. 0 if the customer hasn't rated yet.This ensures only purchased items can be rated.

## Optimizations

To improve both performance and data integrity, several optimizations were implimented in this database. Indexes were created on frequently searched cloumns such as `idx_customer_first_name`,`idx_customer_last_name`,`idx_product_name`,`idx_category_name`,`idx_order_customer_id`,`idx_order_items_product_id`,`idx_order_items_order_id`,`idx_highrating`, `idx_order_date`,to make quaries like product searchs, customer lookups and orders to execute much faster.

Similarly, in many analytical or reporting quaries, user are interested only in products with good feedback (for example, rating of 4 or 5).instead of scanning the entire `rating`,table, a partial index `good_ratings` was createdon the rating table for ratings greater than 3.

The `Product_category_view` is created to display each product along with its corresponding category name. This view simplifies queries by allowing users to easily identify and list all products under a particular category without performing explicit table joins.

## Limitations

The current schema assumes one rating per purchased product and it does not currently track shipping or payment details.