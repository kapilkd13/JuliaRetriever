module retriever
using DataFrames   #using Dataframe package

export install,fetch,datasets   #available for calling directly

function run_shell_cmd(command=`retriever`)  #function to run commands on shell
  Base.run(`$command`)
end

function install(dataset, connection; db_file=nothing, conn_file="./Connection.conn",data_dir='.', log_dir=nothing,debug=false,not_cached=true)
  if !isdefined(:connection)   #check connection/backend is provided
    println("The argument 'connection' must be set to one of the following options: 'mysql', 'postgres', 'sqlite', 'msaccess', 'csv','json','xml'")
    return
  elseif (connection == "mysql"||connection=="postgres")
    if (!isfile(conn_file))
       format = "\n    host my_server@myhost.com\n  port my_port_number\n    user my_user_name\n    password my_pass_word"
       println("conn_file:  $conn_file does not exist. To use a $connection server create a 'conn_file' with the format: $format")
       return
    end
    df = readtable("$conn_file", separator = '\t',header=false)
    setting_Dict=Dict()    #creating setting dictionary from user provided Connection file
    for row in eachrow(df)
      setting_Dict["$(row[1])"]=row[2]
    end
     println("Using conn_file:, $conn_file to connect to a  $connection server on host:  $(setting_Dict["host"])")
     if debug   # set debug mode
       command = `retriever install --debug $connection $dataset --user $(setting_Dict["user"]) --password $(setting_Dict["password"]) --host $(setting_Dict["host"]) --port $(setting_Dict["port"]) --not_cached $not_cached`
     else
     command = `retriever install $connection $dataset --user $(setting_Dict["user"]) --password $(setting_Dict["password"]) --host $(setting_Dict["host"]) --port $(setting_Dict["port"])`
     end
   elseif (connection=="sqlite"||connection=="msaccess")
     if !isfile(db_file)
       command=`retriever install $connection $dataset`
     else
       command=`retriever install $connection $dataset --file $db_file`
     end
   elseif connection=="csv"||connection=="json"||connection=="xml"
     tb_name=joinpath("$data_dir", "{db}_{table}.csv")
     command = `retriever install $connection --table_name $tb_name  $dataset `
   else
     println("The argument 'connection' must be set to one of the following options: 'mysql', 'postgres', 'sqlite', 'msaccess', 'csv', 'json' or 'xml'")
   end
   run_shell_cmd(command)
end


function fetch(dataset)
  temp_path=tempdir()    # user's temporary directory
  install(dataset,"csv",data_dir=temp_path)
  dataset_underscore=replace(dataset,"-","_")
  filelist = filter(x->contains(x,dataset_underscore), readdir(temp_path))  # get files with name similiar to dataset name
  out=Dict()      # dictionary for returning multiple dataframes together,(key=>value)dataset_name=> DataFrame
  for file in filelist
    out["$(replace(file,".csv",""))"]=readtable(joinpath(temp_path,file))
  end
  return out
end


function datasets()           #lists all the available datasets
  run_shell_cmd(`retriever ls`)
end

end
