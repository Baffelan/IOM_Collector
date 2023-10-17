articles = collector(999, today()-Day(2), ENV["NEWSAPIKEY"],ENV["IOMBCKHOST"],ENV["IOMBCKDB"],ENV["IOMBCKUSER"],ENV["IOMBCKPASSWORD"])

user = Dict([string(k)=>v for (k,v) in pairs(user_from_id(999))])

py"write_results"(articles[1:end], "raw", user)


for i in eachindex(articles)
    if length(articles[i])==23
        println(i)
    end
end


for k in keys(articles[11599]) 
    if !(k in keys(articles[11419]))
        println(k)
    end
end

articles[11420]["url"]

articles[11421]
#eventregistry
#psycopg2
#pandas
#apscheduler