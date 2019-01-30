# MariaDB/MySql Database setup scripts
# phpbasics_setup.sql
# Paul Lockyer ( plockyer@googlemail.com)
# 2019-01-25
# Version 1
# Script to setup the database and tables needed to practice my php skills

# Database creation
create or replace database php_basics character set 'utf8mb4' collate 'utf8mb4_unicode_ci';

# Create a table to allow us to practice selecting, adding and deleting into
# Just a simple contacts list:
# Name, phone number, country and country code
create or replace table if not exists contacts(
    contact_id int not null auto_increment primary key,
    forename varchar(100) not null,
    lastname varchar(150) not null,
    telephone_num varchar(20) not null,
    country_area_code int not null
);

# Create the user that the web app should connect in with
create or replace user if not exists 'phpbasics'@'%' identified by 'phpbasics';

# Grant specific privilages to that user
grant SELECT,INSERT,DELETE,UPDATE on php_basics.contacts to 'phpbasics';
