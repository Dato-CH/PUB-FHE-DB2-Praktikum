This project focuses on task 3: streaming services.

# Task 1 - 2
task 1 and 2 is pure theory and visualized in the powerpoint

# Task 3 - 4
for task 3 and 4 docker, MySQL and MySQL Workbench was used

## Docker setup
A new mysql docker container was created using

```
docker pull mysql:latest;
docker run -p 3306:3306 --name fh-db2-praktikum -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=fh-db2-praktikum -d mysql;
```

## MySQL Workbench setup
Before starting the raw data was imported as data_raw.csv using the MySQL Workbench's data import wizard.

The import wizards of MySQL Workbench is however buggy when importing tables with typed data but also null values.
Thus all data was imported as a string/varchar/text first to avoid any data loss, and later got cast to the correct types 
by the SQL scripts. 
 