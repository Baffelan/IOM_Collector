function query(keywords, dates)
    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            "query"=> Dict(
                "and"=> Dict(
                    "dateStart"=> "$(dates[1])",
                    "dateEnd"=> "$(dates[2])",
                    "keyword"=> keywords[1]
                )
            )
            ),
        "articlesPage"=> 1,
        "articlesCount"=> 100,
        "articlesSortBy"=> "socialScore",
        "articlesSortByAsc"=> false,
        "articlesArticleBodyLen"=> -1,
        "includeArticleSocialScore"=> true,
        "resultType"=> "articles",
        "apiKey"=>authentication()
    )
    
end

q = query(["a", "great", "keyword"], [Date("2023-01-01"), Date("2023-01-02")])

q = Dict("query"=>Dict("keyword"=> "Musk"), "apikey"=>ENV["NEWSAPIKEY"])

using HTTP
using JSON
const URL = "http://eventregistry.org/api/v1/article/getArticles"

headers = Dict("Content-Type"=> "application/json","apiKey"=>ENV["NEWSAPIKEY"])

function make_API_call(url,q)
    try
        response = HTTP.get(url, JSON.json(headers), q)
        return String(response.body)
    catch e
        return "Error occurred : $e"
    end
end


response = make_API_call(URL,JSON.json(q))
println(response)