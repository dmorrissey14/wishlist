# wishlist
The-Wishlist

The Wishlist is a gift registry that allows users to create wish lists of gifts and mark friends' gifts as purchased on their own lists. It is a web application running on the Ruby on Rails framework.

# Getting Started

Prior to opening the repository, you'll need the following installed on your machine
 
 * Ruby (version 2.4.1 or higher)
 * Bundler (http://bundler.io/)
 * Microsoft SQL Server 
 
 # Configuring the Database

 Create or identify a Microsoft SQL Server instance for the application to use. The instance should be configured to allow the following:

 * Configure the instance to allow SQL Authentication
 * Configure a SQL authentication login with the `sysadmin` server role.
 * Ensure the instance is configured to allow remote connections.
 * Ensure the instance is configured to allow TCP/IP connections.
 * If using dynamic port assignment for network access, ensure the SQL Browser service is running.

 # Installing
 
 After copying the repository there are two steps to get the web application up and running
 
 * Navigate to the `/project` folder of the repository and run the command `bundle install`. This will install all gems specified in the project, giving you all required dependencies
 * Create the environment variables for database access. The environment variable names must match those used in the `/project/config/database.yml` file. Make sure to restart your shell and/or IDE following the creation of these variables.
 * Navigate to the `/project/bin` folder and run `rake db:create`. This will set up your database schema on your installed instance of SQL Server. (Note: if this shows connection issues, please ensure your environment variables are set correctly.)
 
 # Running the Application
 
 To run the application locally, navigate to the `/project` folder and run `rails server`. This will start a rails server running locally. Then, navigate to `http://localhost:3000` in your browser and the homepage of the website will pop up.
 
 # Running the tests
 
 To run tests, navigate to the `/project/bin` folder and run `rake spec`. This will run all tests created in the spec folder (which is from a add on testing library called RSpec).

 Each test run generates a code coverage report available in the `/project/coverage` folder. For additional statistics about the project, run `rake stats` to get a statistics tables printed to the terminal.
 
 # Deployment
 
 * Request IAM authentication credentials from AWS account owner. 
 * Install Elastic Beanstalk CLI and dependencies.
 * Run "eb init" in project folder and follow through the prompts. Our production environment is called "aws-deploy".
 * Run "eb deploy" in the project folder.
 
 # Built With
 
 * Rails
 * Tiny TDS
 * Microsoft SQL Server
 * Bootstrap

# Authors

* Duncan Morrissey
* Ed Ryan
* Zach Lister
* Ben Mitchell
* Yiannis Karavas

# License

This project is licensed under the MIT License.

