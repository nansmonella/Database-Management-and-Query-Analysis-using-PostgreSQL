# Database-Management-and-Query-Analysis-using-PostgreSQL
This project involves executing several SQL queries on a relational database utilizing an e-commerce dataset. PostgreSQL server is used in a local environment. The project has three parts: creating the database with provided CSV files, writing precise SQL queries to address certain problems, and the creation of triggers and views.

The database is designed with the following tables: 'product_category', 'customers', 'geolocation', 'order_payments', 'order_items', 'orders', 'sellers', 'products', and 'order_reviews'. Each of these tables contain relevant columns as per their respective functions and uses. All identifier columns are string type with a length of 32 and all date and timestamp columns are considered as timestamp values.

The tasks for this project are as follows:

Database Creation: Here, a 'task1.sql' file is created which contains SQL statements used to establish the tables, based on given CSV files.
SQL Queries: SQL queries are created for different subtasks. Each subtask file is titled in the format 'task2 query1.sql', 'task2 query2.sql', etc. The problems addressed include determining customer cities, seller shipping speed, product delivery rates, top-rated sellers, highest shopping cart totals, best sellers, top-rated products, potential product categories for new sellers, cross-tabulation statistics, and window functions.
Triggers and Views: This part of the project involves the creation of database triggers for certain automated responses. Examples include maintaining average review scores of products consistent with user review scores, and preventing the addition of new sellers with an invalid zip code. A view called "order product customer review" is created and the differences in execution time between standard view and materialized view are studied.
In conclusion, this project applies practical SQL skills on a relational database to analyze e-commerce data and manage data changes effectively with the use of database triggers and views.
