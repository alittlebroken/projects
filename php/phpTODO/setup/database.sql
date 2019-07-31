## Mariadb database creation script
## database.sql
## Paul Lockyer
## 31st July 2019

## Create the database
CREATE DATABASE IF NOT EXISTS phpTODO CHARACTER SET = 'utf8' COLLATE = 'utf8_general_ci';

## Now select the DB to be able to create tables inside of it
USE phpTODO;

## Create some tables

## 
