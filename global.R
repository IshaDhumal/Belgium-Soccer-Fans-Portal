# the necessary packages
library(highcharter)
library(leaflet)
library(RPostgres)
library(shiny)
library(shinyalert)
library(shinyanimate)
library(shinyjs)
library(shinythemes)
library(shinyWidgets)
library(tidyverse)

# connection to the wc_24b_07 database----
# replace with your server credentials
con <- dbConnect(
  drv = dbDriver('Postgres'), 
  dbname = 'wc_24b_07',
  host = 'db-postgresql-nyc1-44203-do-user-8018943-0.b.db.ondigitalocean.com', 
  port = 25061,
  user = 'proj7', 
  password = 'AVNS_UgtK7ytr0q_GSk5o0GJ',
  sslmode = 'require'
)

# teammate tibble----
teammate = tibble(
  first = c(
    'Isha',
    'Michael',
    'Tanay',
    'Vladislav',
    'Yuxuan'
  ),
  last = c(
    'Dhumal',
    'Li',
    'Gupta',
    'Shepelenko',
    'Zhao'
  )#,
  #info = c(
   # 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed neque urna, sodales id nibh nec, rhoncus pretium lectus.',
  #  'Nunc convallis turpis nibh, et iaculis lacus ornare et. Cras vel quam velit. Vestibulum ante ipsum primis in faucibus orci luctus.',
   # 'Mauris quis sem vitae urna volutpat luctus. Duis hendrerit elit sit amet faucibus tristique.',
    #'Praesent congue sapien sem, et porttitor mauris bibendum non. Ut ac faucibus massa. Proin eu hendrerit nibh, fringilla sollicitudin arcu.',
    #'Quisque a arcu sollicitudin, ornare urna sit amet, molestie arcu. Fusce posuere, neque ut pretium tincidunt, odio lacus imperdiet velit.'
  #)
)

