module IOM_Collector
    using PyCall
    using Conda
    using WritePostgres
    using Dates
    

    include("collector.jl")
    include("collect_day.jl")

    export collector
    export collect_day
end    
#collector(999, Date("2023-08-28"), ENV["NEWSAPIKEY"],ENV["IOMBCKHOST"],ENV["IOMBCKDB"],ENV["IOMBCKUSER"],ENV["IOMBCKPASSWORD"])