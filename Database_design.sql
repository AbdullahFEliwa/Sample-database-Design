
create table sales.staffs(
staff_id int not null  unique primary key ,
first_name varchar(10) not null ,
last_name varchar(10) not null ,
phone varchar(11)not null unique,
email varchar(25) not null unique,
activee tinyint not null,
store_id int ,
manager_id int ,
foreign key (store_id) references stores(store_id) on delete cascade on update cascade,
foreign key (manager_id) references sales.staffs(staff_id) on delete cascade on update cascade
);
create table sales.stores(
store_id int not null  unique primary key ,
store_name varchar(10) not null,
phone varchar(11),
email varchar(25) not null,
street varchar(30),
city varchar(30),
state varchar(15),
zip_code varchar(5)
  
);
create table sales.orders(
order_id int not null  unique primary key ,
customer_id int references sales(customers) ON DELETE CASCADE ON UPDATE CASCADE,
order_status tinyint not null,
order_date date not null,
required_date date NOT NULL,
shipped_date date,
store_id int references stores(store_id) ON DELETE CASCADE ON UPDATE CASCADE,
staff_id int references staffs(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE sales.orders
drop staff_id;
alter table sales.orders
add staff_id int references staffs(staff_id) ON DELETE no action ON UPDATE no action;

create database production;

create table production.brand(
brand_id int unique not null primary key ,
brand_name varchar(100) not null
);

create table production.categories(
category_id int primary key unique not null,
category_name varchar(200) not null 
);

create table production.products(
product_id int unique primary key not null,
product_name varchar(40) not null,
brand_id int not null,
category_id int not null,
model_year year,
list_price decimal(8,2),
foreign key (category_id) references production.categories(category_id) on delete cascade on update cascade,
foreign key (brand_id) references production.brand(brand_id) on delete cascade on update cascade 
);

create table sales.order_items(
order_id int ,
item_id int ,
product_id int not null,
quantity int not null,
list_price decimal(8,2) not null,
discount decimal(4,2) not null default 0,
foreign key (order_id) references sales.orders(order_id) on delete cascade on update cascade,
foreign key (product_id) references production.products(product_id) 

);

create table production.stock(
store_id int references sales.stores(store_id) on delete no action on update no action,
product_id int references products(product_id) on delete no action on update no action,
quantity int not null
);
