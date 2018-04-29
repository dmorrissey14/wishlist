# wishlist
The-Wishlist

The Wishlist is a gift registry that allows users to create wish lists of gifts and mark friends' gifts as purchased on their own lists. It is a web application running on the Ruby on Rails framework.

# Getting Started

Prior to opening the repository, you'll need the following installed on your machine
 
 * Ruby (version 2.4.1 or higher)
 * Bundler (http://bundler.io/)
 * SQL Server 
 
 # Installing
 
 After copying the repository there are two steps to get the web application up and running
 
 * Navigate to the `/project` file of the repository and run the command `bundle install`. This will install all gems specified in the project, giving you all required dependencies
 * Environment variables...
 * Navigate to the `/project/bin` folder and run `rake db:create`. This will set up your database schema on your installed instance of SQL Server.
 
 # Running the Application
 
 To run the application locally, navigate to the `/project` folder and run `rails server`. This will start a rails server running locally. Then, navigate to `http://localhost:3000` in your browser and the homepage of the website will pop up.
 
 # Running the tests
 
 To run tests, navigate to the `/project/bin` folder and run `rake spec`. This will run all tests created in the spec folder (which is from a add on testing library called RSpec).
 
 # Deployment
 
 Ben can you fill out this section?
 
 # Built With
 
 * Rails
 * Tiny TDS
 * SQL Server
 * Bootstrap

# Authors

* Duncan Morrissey
* Ed Ryan
* Zach Lister
* Ben Mitchell
* Yiannis Karavas

# License

This project is licensed under the MIT License.

