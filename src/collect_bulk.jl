
# # Conda.pip_interop(true)
# # Conda.pip("install", "eventregistry")
# function collect_bulk(userID,newsapikey,backhost,backdb,backuser,backpassword)
#     py"""
#     from eventregistry import *
#     import json

#     from datetime import datetime, timedelta, date
#     import sys
#     import os

#     from apscheduler.schedulers.blocking import BlockingScheduler


#     import psycopg2
#     import pandas as pd
#     from sqlalchemy import create_engine
#     import datetime as dt

#     def query_api(user):
#         er = EventRegistry(apiKey = $(newsapikey))
#         usUri = er.getLocationUri(user["keywords"]["location"])
#         q = QueryArticlesIter(
#             keywords = QueryItems.OR(user["keywords"]["keywords"]),
#             lang = user["keywords"]["language"],
#             sourceLocationUri = usUri,
#             dataType = ["news", "blog"],
#             dateStart = dt.date(2023, 5, 1),
#             keywordsLoc = "body",
#             startSourceRankPercentile = 0,
#             endSourceRankPercentile = 100)

#         # obtain at most 500 newest articles or blog posts, remove maxItems to get all
#         results = q.execQuery(er, 
#                     #sortBy = "date", 
#                     maxItems = 15000, 
#                     returnInfo = ReturnInfo(articleInfo=ArticleInfoFlags(socialScore=True, concepts=True, categories=True)))
#         return(results)
#     # end

#     def write_results(data, table, user):

#         connection = psycopg2.connect(
#             host=$(backhost),
#             database=$(backdb),
#             user=$(backuser),
#             password=$(backpassword))
#         try:
#             # create connection
#             print("111")
            

            
#             # cursor object
#             cursor = connection.cursor()
            
#             # query insert
#             # create a placeholder to insert values
#             f = [d for d in data][0]
#             tables = "INSERT INTO {}{}, collectionDate, user_ID, collection_ID, keywords".format(table, tuple(f.keys())).replace("'","").replace(")","")+")"
#             kwarray = json.dumps(user["keywords"]["keywords"]).replace("[","{").replace("]","}")
#             values = " VALUES("+(len(f.values())-1)*"%s, "+"%s, '{}','{}','{}','{}')".format(date.today(),user["userid"],user["collectionid"],kwarray)
#             conflict = "ON CONFLICT (field_one) DO NOTHING" # Needs implementing 
#             query = tables + values

#             # create an insert list
            
#             def format_dicts(ds):
#                 for (k, v) in ds.items():
#                     if isinstance(v, dict):
#                         ds[k] = json.dumps(v)
#                     elif isinstance(v, list):
#                         ds[k] = [json.dumps(d) if isinstance(d, dict) else d for d in ds[k]]
#                 return tuple(ds.values())

#             records =  [format_dicts(ds) for ds in data]


#             # Execute query 
#             for r in records:
#                 try:
#                     cursor.execute(query, r)
#                 except psycopg2.errors.UniqueViolation:
#                     connection.rollback()
#                     print("Found Duplicate uri")
            
#             # commit changes
#             connection.commit()
        
#             # print a message
#             print("rows inserted successfully")

#         except OSError as e:
#             print("222")
#             connection.rollback()
#             print(e)
#             print("Error inserting table")

#         finally:
#             print("333")
#             connection.close()
#             print("connection closed")

#     #end

#     def collect(user):
#         print(user)
#         results = query_api(user)
#         l = [art for art in results]


#         if len(l)>0:
#             print(l[0]["date"])
#             write_results(l, "raw", user)
#         else:
#             print("None found")
#         return(l)
#     #end

#     query_api, write_results, collect
#     """


#     user = Dict([string(k)=>v for (k,v) in pairs(user_from_id(userID))])

#     results = py"collect"(user)
# end

