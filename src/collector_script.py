from eventregistry import *
import json

from datetime import datetime, timedelta, date
import sys
import os

from apscheduler.schedulers.blocking import BlockingScheduler


import psycopg2
import pandas as pd
from sqlalchemy import create_engine
import datetime as dt






def query_api(user):
    er = EventRegistry(apiKey = user["key"])
    usUri = er.getLocationUri(user["location"])
    q = QueryArticlesIter(
        keywords = QueryItems.OR(user["keywords"]),
        sourceLocationUri = usUri,
        dataType = ["news", "blog"],
        dateStart = dt.date(2023, 4, 4),
        keywordsLoc = "body",
        startSourceRankPercentile = 0,
        endSourceRankPercentile = 100)

    # obtain at most 500 newest articles or blog posts, remove maxItems to get all
    results = q.execQuery(er, 
                #sortBy = "date", 
                maxItems = 10000, 
                returnInfo = ReturnInfo(articleInfo=ArticleInfoFlags(socialScore=True, concepts=True, categories=True)))
    return(results)
# end


def write_results(data, table):
    connection = psycopg2.connect(
        host="localhost",
            database="newsdatabase",
            user="ndbuser",
            password="small")
    try:
        # create connection
        print("111")
        

        
        # cursor object
        cursor = connection.cursor()
        
        # query insert
        # create a placeholder to insert values
        f = [d for d in data][0]
        query =query ="""INSERT INTO {}{}, collectionDate""".format(table, tuple(f.keys())).replace("'","").replace(")","")+""")"""+""" VALUES("""+(len(f.values())-1)*"""%s, """+"""%s, '{}')
        """.format(date.today())

        # create an insert list
        
        def format_dicts(ds):
            for (k, v) in ds.items():
                if isinstance(v, dict):
                    ds[k] = json.dumps(v)
                elif isinstance(v, list):
                    ds[k] = [json.dumps(d) if isinstance(d, dict) else d for d in ds[k]]
            return tuple(ds.values())

        records =  [format_dicts(ds) for ds in data]


        # Execute query 
        for r in records:
            try:
                cursor.execute(query, r)
            except psycopg2.errors.UniqueViolation:
                connection.rollback()
                print("Found Duplicate uri")
        
        # commit changes
        connection.commit()
	
        # print a message
        print("rows inserted successfully")

    except OSError as e:
        print("222")
        connection.rollback()
        print(e)
        print("Error inserting table")

    finally:
        print("333")
        connection.close()
        print("connection closed")

#end



def collect(user):
    results = query_api(user)
    l = [art for art in results]


    if len(l)>0:
        print(l[0]["date"])
        write_results(l, "NewsAPI")
    else:
        print("None found")
    return(l)

sys.modules[__name__] = execute



if __name__ == '__main__':
    f = open("user1.json")
    user = json.load(f)
    f.close()
    execute(user)
    # scheduler = BlockingScheduler()
    # scheduler.add_job(execute, 'interval', minutes=1)
    # print('To clear the alarms, delete the example.sqlite file.')
    # print('Press Ctrl+{0} to exit'.format('Break' if os.name == 'nt' else 'C'))

    # try:
    #     scheduler.start()
    # except (KeyboardInterrupt, SystemExit):
    #     pass

