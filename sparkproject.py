import pandas as pd
import numpy as np

sales=pd.read_csv(".venv\Sales.csv")
customers=pd.read_csv(".venv\Customers.csv", encoding='latin-1')
exchangerates=pd.read_csv(".venv\Exchange_Rates.csv")
products=pd.read_csv(".venv\Products.csv")
stores=pd.read_csv(".venv\Stores.csv")

sales["Order Date"] = pd.to_datetime(sales["Order Date"], format="%m/%d/%Y")
sales["Delivery Date"] = pd.to_datetime(sales["Delivery Date"], format="%m/%d/%Y", errors="coerce")
sales["Currency Code"]=sales["Currency Code"].astype(str)
sales.fillna("Not Available", inplace=True)

stores.fillna(0, inplace=True)
stores["Country"]=stores["Country"].astype(str)
stores["State"]=stores["State"].astype(str)
stores["Open Date"]=pd.to_datetime(stores["Open Date"], format="%m/%d/%Y")

products["Unit Cost USD"]=products["Unit Cost USD"].replace("[\$,]", "", regex=True).astype(float)
products["Unit Price USD"]=products["Unit Price USD"].replace("[\$,]", "", regex=True).astype(float)

customers["State Code"].fillna("Not Available", inplace=True)
customers["Birthday"]=pd.to_datetime(customers["Birthday"], format="%m/%d/%Y", errors="coerce")

exchangerates["Date"]=pd.to_datetime(exchangerates["Date"], format="%m/%d/%Y", errors="coerce")

overall=sales
overall=pd.merge(overall, customers, on="CustomerKey", how="inner")
overall=pd.merge(overall, exchangerates, left_on=["Order Date", "Currency Code"], right_on=["Date", "Currency"],how="inner")
overall=pd.merge(overall, products, on="ProductKey", how="inner")
overall=pd.merge(overall, stores, on=["StoreKey", "Country", "State"], how="inner")
overall

col=list(overall.columns)
col1=[]
for c in col:
  col1.append(c.replace(' ','_').lower())
overall.columns=col1

import mysql.connector
import pymysql
from sqlalchemy import create_engine

host="localhost"
port="3306"
username="root"
password="BLEanc1994"
database="dataspark"

engine_string=f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}"
engine=create_engine(engine_string)

table_name="overall"
overall.to_sql(table_name, engine, if_exists="replace", index=False)
print(f"successfully imported {table_name} to sql")

table_name="customers"
customers.to_sql(table_name, engine, if_exists="replace", index=False)
print(f"successfully imported {table_name} to sql")

table_name="products"
products.to_sql(table_name, engine, if_exists="replace", index=False)
print(f"successfully imported {table_name} to sql")

table_name="exchangerates"
exchangerates.to_sql(table_name, engine, if_exists="replace", index=False)
print(f"successfully imported {table_name} to sql")

table_name="stores"
stores.to_sql(table_name, engine, if_exists="replace", index=False)
print(f"successfully imported {table_name} to sql")
