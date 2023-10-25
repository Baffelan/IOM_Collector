
using HTTP
using JSON
const URL = "http://eventregistry.org/api/v1/article/getArticles"

headers = Dict("Content-Type"=> "application/json","apiKey"=>ENV["NEWSAPIKEY"])

function execute_query(url,q, key)
    headers = Dict("Content-Type"=> "application/json","apiKey"=>key)

    try
        response = HTTP.get(url, headers, JSON.json(q))
        return String(response.body)
    catch e
        return e
    end
end

arts = make_API_call(URL, q)

arts = JSON.parse(arts)

for i in 1:100
    println(arts["articles"]["results"][i]["url"])
end