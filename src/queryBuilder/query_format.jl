function query_format()

    "query": {
        "$query": {
          "$and": [
            {
              "dateStart": "2017-04-22",
              "dateEnd": "2017-04-22",
              "categoryUri": "dmoz/Business"
            },
            {
              "$or": [
                {
                  "conceptUri": "http://en.wikipedia.org/wiki/Barack_Obama"
                },
                {
                  "keyword": "Trump"
                }
              ]
            }
          ]
        }
      },
end