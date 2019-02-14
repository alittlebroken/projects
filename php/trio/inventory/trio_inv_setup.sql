# Triometric Inventory Database setup

## DATABASE ##
# Create the database itself
CREATE DATABASE IF NOT EXISTS trio_inventory CHARACTER SET = 'utf8' COLLATE = 'utf8_general_ci';

## USERS ###
# Create the admin user
CREATE USER IF NOT EXISTS trioinv_adm identified by 'Arg534j@#92';
# Give it the correct permissions
GRANT ALL ON trio_inventory.* TO trioinv_adm;

# Create the app user
CREATE USER IF NOT EXISTS trioinv_usr identified by 'G34@7;+wTr6';
GRANT DELETE,INSERT,SELECT,UPDATE on trio_inventory.* to trioinv_usr;

## TABLES ##
CREATE TABLE IF NOT EXISTS customers(

);
