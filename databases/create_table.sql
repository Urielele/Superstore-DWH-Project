-- public.dim_customer definition

-- Drop table

-- DROP TABLE public.dim_customer;

CREATE TABLE public.dim_customer (
	customer_key serial4 NOT NULL,
	customer_name varchar(100) NOT NULL,
	segment varchar(50) NOT NULL,
	CONSTRAINT pk_dim_customer PRIMARY KEY (customer_key),
	CONSTRAINT uq_dim_customer UNIQUE (customer_name, segment)
);
CREATE INDEX idx_dim_customer_segment ON public.dim_customer USING btree (segment);


-- public.dim_location definition

-- Drop table

-- DROP TABLE public.dim_location;

CREATE TABLE public.dim_location (
	location_key int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	state varchar(100) NOT NULL,
	country varchar(100) NOT NULL,
	region varchar(50) NOT NULL,
	market varchar(50) NOT NULL,
	CONSTRAINT pk_dim_location PRIMARY KEY (location_key)
);
CREATE INDEX idx_dim_location_market ON public.dim_location USING btree (market);
CREATE INDEX idx_dim_location_region ON public.dim_location USING btree (region);


-- public.dim_product definition

-- Drop table

-- DROP TABLE public.dim_product;

CREATE TABLE public.dim_product (
	product_key serial4 NOT NULL,
	product_name varchar(255) NOT NULL,
	category varchar(50) NOT NULL,
	sub_category varchar(50) NOT NULL,
	CONSTRAINT pk_dim_product PRIMARY KEY (product_key),
	CONSTRAINT uq_dim_product UNIQUE (product_name, category, sub_category)
);
CREATE INDEX idx_dim_product_category ON public.dim_product USING btree (category);


-- public.dim_time definition

-- Drop table

-- DROP TABLE public.dim_time;

CREATE TABLE public.dim_time (
	time_key int4 NOT NULL,
	full_date date NOT NULL,
	"day" int2 NOT NULL,
	day_name varchar(15) NOT NULL,
	"month" int2 NOT NULL,
	month_name varchar(15) NOT NULL,
	quarter int2 NOT NULL,
	"year" int2 NOT NULL,
	week_of_year int2 NOT NULL,
	is_weekend bool DEFAULT false NOT NULL,
	CONSTRAINT dim_time_day_check CHECK (((day >= 1) AND (day <= 31))),
	CONSTRAINT dim_time_month_check CHECK (((month >= 1) AND (month <= 12))),
	CONSTRAINT dim_time_quarter_check CHECK (((quarter >= 1) AND (quarter <= 4))),
	CONSTRAINT dim_time_week_of_year_check CHECK (((week_of_year >= 1) AND (week_of_year <= 53))),
	CONSTRAINT pk_dim_time PRIMARY KEY (time_key)
);
CREATE INDEX idx_dim_time_month ON public.dim_time USING btree (year, month);
CREATE INDEX idx_dim_time_year ON public.dim_time USING btree (year);


-- public.fact_sales definition

-- Drop table

-- DROP TABLE public.fact_sales;

CREATE TABLE public.fact_sales (
	sales_key int8 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
	order_date_key int4 NOT NULL,
	ship_date_key int4 NOT NULL,
	product_key int4 NOT NULL,
	customer_key int4 NOT NULL,
	location_key int4 NOT NULL,
	order_id varchar(50) NOT NULL,
	ship_mode varchar(50) NOT NULL,
	sales numeric(12, 4) DEFAULT 0 NOT NULL,
	quantity int4 DEFAULT 0 NOT NULL,
	discount numeric(5, 4) DEFAULT 0 NOT NULL,
	profit numeric(12, 4) DEFAULT 0 NOT NULL,
	shipping_cost numeric(10, 4) DEFAULT 0 NOT NULL,
	shipping_days int4 DEFAULT 0 NOT NULL,
	CONSTRAINT fact_sales_discount_check CHECK (((discount >= (0)::numeric) AND (discount <= (1)::numeric))),
	CONSTRAINT fact_sales_quantity_check CHECK ((quantity >= 0)),
	CONSTRAINT fact_sales_shipping_cost_check CHECK ((shipping_cost >= (0)::numeric)),
	CONSTRAINT pk_fact_sales PRIMARY KEY (sales_key),
	CONSTRAINT fact_sales_shipping_days_check CHECK ((shipping_days >= 0)),
	CONSTRAINT fk_fs_customer FOREIGN KEY (customer_key) REFERENCES public.dim_customer(customer_key),
	CONSTRAINT fk_fs_location FOREIGN KEY (location_key) REFERENCES public.dim_location(location_key),
	CONSTRAINT fk_fs_order_date FOREIGN KEY (order_date_key) REFERENCES public.dim_time(time_key),
	CONSTRAINT fk_fs_product FOREIGN KEY (product_key) REFERENCES public.dim_product(product_key),
	CONSTRAINT fk_fs_ship_date FOREIGN KEY (ship_date_key) REFERENCES public.dim_time(time_key)
);
CREATE INDEX idx_fs_customer ON public.fact_sales USING btree (customer_key);
CREATE INDEX idx_fs_location ON public.fact_sales USING btree (location_key);
CREATE INDEX idx_fs_order_date ON public.fact_sales USING btree (order_date_key);
CREATE INDEX idx_fs_order_id ON public.fact_sales USING btree (order_id);
CREATE INDEX idx_fs_product ON public.fact_sales USING btree (product_key);