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
# Inventory customers
CREATE TABLE IF NOT EXISTS customers(
    customer_id INT AUTO INCREMENT NOT NULL PRIMARY_KEY,
    name VARCHAR(75) NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NULL,
    status_id INT NO NULL DEFULT 0
);

# INSERT INTO customers (name) values ("Triometric");
# INSERT INTO customers (name) values ("GTA");
# INSERT INTO customers (name) values ("Hotelbeds");

# Inventory statuses
CREATE TABLE IF NOT EXISTS statuses(
    status_id INT AUTO INCREMENT NOT NULL PRIMARY_KEY,
    name VARCHAR(50) NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMP NULL
);

# INSERT INTO statuses(name) VALUES ("Active");
# INSERT INTO statuses(name) VALUES ("Not active");

# Inventory machine_type
CREATE TABLE IF NOT EXISTS machine_types(
  machinetype_id INT AUTO INCREMENT NOT NULL PRIMARY_KEY,
  name varchar(30) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP NULL
);

# INSERT INTO machine_types (name) VALUES ("Desktop");
# INSERT INTO machine_types (name) VALUES ("Laptop");
# INSERT INTO machine_types (name) VALUES ("Server");
# INSERT INTO machine_types (name) VALUES ("Printer");
# INSERT INTO machine_types (name) VALUES ("Switch");
# INSERT INTO machine_types (name) VALUES ("Firewall");
# INSERT INTO machine_types (name) VALUES ("Router");

# Inventory software_type
CREATE TABLE IF NOT EXISTS software_types(
  softwaretype_id INT AUTO INCREMENT NOT NULL PRIMARY_KEY,
  name varchar(30) NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated TIMESTAMP NULL
);

# INSERT INTO software_types (name) VALUES ("Operating System");
# INSERT INTO software_types (name) VALUES ("Application");

# Inventory Manufacturers
# Inventory machines
CREATE TABLE IF NOT EXISTS machines(
  machine_id INT AUTO INCREMENT NOT NULL PRIMARY_KEY,
  customer_id INT NOT NULL,
  machine_type_id INT NT NULL,
  hostname VARCHAR(250) NOT NULL
);
