function query_newsapi(user, dates, key; num_articles=15000)
    query_strs = write_queries(user)
    results = execute_queries(query_strs)
    vcat([res["articles"]["results"] for res in results]...)
    #####

    URL = "http://eventregistry.org/api/v1/article/getArticles"
    u_args = user["keywords"]
    
    paged_articles = []
    page = 0
    total_articles = 1
    while 100*page<min(total_articles,num_articles) # multiply by 100 as is max number of articles returned by newsapi
        page = page+1
        query_str = write_query(u_args["keywords"], u_args["location"], u_args["language"], dates, page)
        result = execute_query(URL, query_str, key)
        total_articles = result["totalResults"]
        push!(paged_articles, result["results"])

    end
    vcat(paged_articles...)
end

user["keywords"]