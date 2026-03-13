use pharmacy ; 
select * from categories ; 
select * from stock_data ; 
DESCRIBE stock_data ;  

-- Primary keys -----------------------------

alter table categories add primary key (category_id) ;
alter table customers add primary key (customer_id) ;
alter table employees add primary key (employee_id) ;
alter table products add primary key (product_id) ;
alter table sales add primary key (sale_id) ; 
alter table stock_data
add column id int auto_increment primary key ;
alter table stores_data add primary key (store_id) ; 
alter table suppliers add primary key (supplier_id) ; 
-- Relation ships ---------
alter table sales 
add constraint fk_sales_product 
foreign key (product_id) references products(product_id);

alter table sales 
add constraint fk_sales_employee
foreign key (employee_id) references employees(employee_id) ;

alter table sales 
add constraint fk_sales_customer
foreign key (customer_id) references customers(customer_id);

alter table sales 
add constraint fk_sales_stores
foreign key (store_id) references stores_data(store_id) ; 


alter table products 
add constraint fk_products_categories
foreign key (category_id) references categories(category_id) ; 

alter table products 
add constraint fk_products_suppliers
foreign key (supplier_id) references suppliers(supplier_id) ;

alter table stock_data 
add constraint fk_stock_store
foreign key (store_id) references stores_data(store_id);  

alter table stock_data 
add constraint fk_stock_products
foreign key (product_id) references products(product_id) ; 
describe employees ;
select 
s.sale_id,
CONCAT(c.first_name,' ',c.last_name) as customer_name,
p.product_name,
st.store_name,
e.employee_name,
s.total_amount
from sales s
join customers c on s.customer_id = c.customer_id
join products p on s.product_id = p.product_id
join stores_data st on s.store_id = st.store_id
join employees e on s.employee_id = e.employee_id
limit 20;

CREATE TABLE customers_backup AS SELECT * FROM customers;
CREATE TABLE sales_backup AS SELECT * FROM sales;
CREATE TABLE products_backup AS SELECT * FROM products ; 


describe customers ;
-- cleaning data 
select * from customers 
where customer_id is null 
	or first_name is null
	or last_name is null ;
delete from  customers
where customer_id is null 
or first_name is null
or last_name is null;
describe sales ; 
select * from sales 
	where total_amount is null 
    or sale_date is null ;
    
describe categories ;
select * from categories 
	where category_id is null 
    or category_name is null ; 
describe employees ; 
select * from employees 
where employee_id is null 	
	or employee_name is null ;
describe products ; 
select * from products 
where product_id is null 
	or product_name is null ;

describe stock_data ; 
	select * from stocK_data 
    where stock_id is null ; 
describe stores_data ; 
select * from stores_data 
	where store_id is null 
    or store_name is null ; 
describe suppliers ; 
select * from suppliers 
where supplier_id is null 
	or supplier_name is null ;
    
describe sales ; 

SELECT 
customer_id,
product_id,
sale_date,
employee_id,
store_id,
total_amount,
COUNT(*) AS cnt
FROM sales
GROUP BY 
customer_id,
product_id,
sale_date,
employee_id,
store_id,
total_amount
HAVING COUNT(*) > 1;