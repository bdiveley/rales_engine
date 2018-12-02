# README

# Rales Engine

Rales Engine is a program that delivers a variety of JSON-formatted data related to customers, merchants, items, invoices, invoice_items and transactions stored in a postsql database.  Accessible data includes endpoints for all table attributes, data filtered by URI query parameters, relationships between tables, and business logic.  Active Record and SQL are utilized to query the database for all business-logic related queries.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

From GitHub clone down repository using the following commands in terminal:
* git clone git@github.com:bdiveley/rales_engine.git
* cd rales_engine

### Prerequisites

You will need Rails installed. Use version 5.1.6.  You will also use Ruby version 2.4.1

To check your version using terminal run: rails -v in the command line.
If you have not installed rails, in terminal run: gem install rails -v 5.1 in the command line.

### Installing

From the root directory of the repo, run these commands:
* bundle
* bundle update
* rake db:{drop,create,migrate}
* rake import:data
* rails s

Open up a web browser

Navigate to localhost:3000/api/v1/...

To gain access to all available URI pathways:
From the terminal, type 'rake routes'

## Running the tests

* Note: Before running RSpec, ensure you're in the project root directory.

From terminal run: rspec

After RSpec has completed, you should see all tests passing as GREEN.  Any tests that have failed or thrown an error will display RED.  Any tests that have been skipped will be displayed as YELLOW.

## Built With

* Rails
* RSpec
* ShouldaMatchers
* Capybara
* Pry
* SimpleCov
* FactoryBot
* PostreSQL

## Authors

* Bailey Diveley - Github: BDiveley
