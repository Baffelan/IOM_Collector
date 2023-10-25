
# In: Location, keywords, date, language
# Out: Iterable of articles
function write_query(keywords, locations, languages, dates, page::Int)
    q = Dict(
        "action"=>action(),
        "query"=> Dict(
            "\$query"=> Dict(
                "\$and"=> [Dict(
                    "dateStart"=> "$(dates[1])",
                    "dateEnd"=> "$(dates[2])"
                ),
                "\$or"=>[Dict(
                "keyword"=> Dict("\$or"=>keywords))]]
            )
            ),
        "articlesPage"=> page,
        "articlesCount"=> 100,
        "articlesSortBy"=> "socialScore",
        "articlesSortByAsc"=> false,
        "articlesArticleBodyLen"=> -1,
        "includeArticleSocialScore"=> true,
        "resultType"=> "articles",
        "apiKey"=>authentication()
    )
    
end
