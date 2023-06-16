# ------------------------------------------------------------------------------------------------ #
# library                                                                                          #
# ------------------------------------------------------------------------------------------------ #
library(shinyjs)
library(shiny)
library(glue)
library(RMySQL)
library(DBI)
# library(jsonlite)
# library(rjson)

# ------------------------------------------------------------------------------------------------ #
# mysql connect                                                                                    #
# ------------------------------------------------------------------------------------------------ #

# RMySQL connect --------------------------------------------------------------------------------- #
con <- dbConnect(
  RMySQL::MySQL(), 
  user="root", 
  password="0000",
  host="127.0.0.1", 
  dbname = "what_to_eat",
  client.flag=CLIENT_MULTI_RESULTS
)

# utf control ------------------------------------------------------------------------------------ #
dbSendQuery(con, "SET NAMES utf8;") 
dbSendQuery(con, "SET CHARACTER SET utf8;") 
dbSendQuery(con, "SET character_set_connection=utf8;")

