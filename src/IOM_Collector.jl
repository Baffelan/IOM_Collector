module IOM_Collector
    using PyCall
    using Conda
    using IOM_WritePostgres
    using Dates
    

    include("collector.jl")
    include("collect_day.jl")
    include("check_python_packages.jl")

    export collector
    export collect_day
    
end    
#collect_day(999, ENV["NEWSAPIKEY"],ENV["IOMBCKHOST"],ENV["IOMBCKDB"],ENV["IOMBCKUSER"],ENV["IOMBCKPASSWORD"])
