# JuliaRetriever
Julia Interface for Data Retriever

This is a sample code which implements functionality like Install, Fetch, and List datasets in a Julia Interface for Retriever.

Additional package used: `DataFrames`

This code has been tested for CSV, MySQL, SQLite, JSON databases on datasets: `iris` and `bird-size`.

Steps to uses this Code:

1. clone this repository and `cd` to this repository.
2. Module code is present in `retriever.jl` file.
3. Load retriever.jl file as module in LOAD_PATH, using  
`push!(LOAD_PATH, "/path/to/retriever/directory")`  
for ex.  
`push!(LOAD_PATH, "/home/kapil/JuliaRetriever")`

4. Update `Connection.conn` file.  
A sample `Connection.conn` file is present in this repository. This file contains information about Mysql/postgresql database. Fields like `user`, `password` need to be changed as per your local machine.  

  Structure of Connection.conn file is :  
  `host`	localhost  
  `port`	3306    
  `database_name`	ndb    
  `user`	root  
  `password`	kapil  
  We use `\t` to separate key and value

5. In order to test the `retriever.jl` module, We have created a `testing.jl` file.
6. Run `testing.jl` using command `julia testing.jl` and you will get output of all the functions in your console. ( Make sure you are in correct directory and you have updated Connection.conn file appropriately)

Any feedback or bug report is appreciated.
