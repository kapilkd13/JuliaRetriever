using retriever

connection="mysql"              # default to mysql
dataset="iris"                  # sample code tested on iris and bird-size
conn_file="./Connection.conn" # relative path to connection file, example file include in directory
db_file="sqlite.db"           # sqlite db file

#list all datasets
datasets()


#checking Install function

#for csv
println("Installing csv file")
connection="csv"
retriever.install(dataset,connection)

#for mysql
println("Installing in mysql Database")
connection="mysql"
retriever.install(dataset,connection,conn_file=conn_file)

#for sqlite
println("Installing in sqlite Database")
connection="sqlite"
retriever.install(dataset,connection,db_file=db_file)

#checking fetch function
println("fetching dataframe")
dframe=retriever.fetch(dataset)
for k in keys(dframe)
  println(dframe["$k"])
end
