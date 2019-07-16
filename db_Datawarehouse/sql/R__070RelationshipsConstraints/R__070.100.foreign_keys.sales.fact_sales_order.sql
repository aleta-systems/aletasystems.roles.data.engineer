IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'fk_sales_fact_sales_order_dim_customer')
    ALTER TABLE sales.fact_sales_order WITH NOCHECK
    ADD CONSTRAINT fk_sales_fact_sales_order_dim_customer
        FOREIGN KEY (customer_sk)
        REFERENCES sales.dim_customer (customer_sk) ;

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'fk_sales_fact_sales_order_dim_supplier')
    ALTER TABLE sales.fact_sales_order WITH NOCHECK
    ADD CONSTRAINT fk_sales_fact_sales_order_dim_supplier
        FOREIGN KEY (supplier_sk)
        REFERENCES sales.dim_supplier (supplier_sk) ;

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'fk_sales_fact_sales_order_dim_product')
    ALTER TABLE sales.fact_sales_order WITH NOCHECK
    ADD CONSTRAINT fk_sales_fact_sales_order_dim_product
        FOREIGN KEY (product_sk)
        REFERENCES sales.dim_product (product_sk) ;