## 2023-07-06 Dima schema updates:
- created function in the dimadev schema to list the `table_name`, `schema_name`, `column_name`, `data_type`, `character_maximum_length` and `character_octet_length`(length of number type) of all the tables within a specified schema. 

- command used to query from this function(querying dimadev in this example):
```sql
select * from dimadev.get_schemas('dimadev');
```

- in order to export the result of that function into a csv file (dimadev schema in this example):
```bash 
psql -h 128.123.177.184 -p 5432 -U kris -d postgres -t -A -F"," -c "select * from dimadev.get_schemas('dimadev')" > dimadevschema.csv
```