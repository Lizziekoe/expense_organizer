Expense Organizer
==========

Creates a web app using Ruby to add a list and allow tasks to be added to a list
using a SQL database.

Database Setup
--------------

```sh
$ psql
$ CREATE DATABASE expense_organizer;
$ \c expense_organizer;
$ CREATE TABLE expenses (id serial PRIMARY KEY, description varchar, amount float, date timestamp);
$ CREATE TABLE categories (id serial PRIMARY KEY, name varchar);
$ CREATE TABLE categories_expenses (id serial PRIMARY KEY, category_id int, expense_id int);
```
App Setup
----------

Assuming you have ruby installed. In the terminal:
```sh
$ gem install bundler
$ bundle
$ ruby app.rb
```

Go to http://localhost:4567 in your browser

Tests
-----

In psql

```sh
$ CREATE DATABASE expense_organizer_test WITH TEMPLATE expense_organizer
```

Testing the ruby methods can be done via rspec.

```sh
$ gem install rspec
$ rspec
```
Motivation
---------

This app was created to practice interacting with SQL databases using PostgreSQL and the PG gem and using many to many relationships.

License
-------

MIT License, copyright 2015. Created by Kathryn Carr & Lizzie Koehler.
