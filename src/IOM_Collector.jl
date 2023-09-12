module IOM_Collector

    include("collect_bulk.jl")
    include("collect_day.jl")

    export collect_bulk
    export collect_day
    
end
