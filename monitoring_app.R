################   init    #################
suppressMessages(library(shiny))
suppressMessages(library(tidyverse))
suppressMessages(library(DT))
suppressMessages(library(jsonlite))
suppressMessages(library(httr))
suppressMessages(library(shinyjs))

source("./resources/functions_app.R")

title_p1 <- "BLH-Monitoring"

app_data <<- fromJSON("./resources/app_data.json")

source("./resources/ui_page1.R")
source("./resources/server_page1.R")

source("./resources/ui_page2.R")
source("./resources/server_page2.R")

source("./resources/ui_page3.R")
source("./resources/server_page3.R")



################    ui     #################
ui <- navbarPage(
    title = title_p1,
    tabPanel("Übersicht", ui_page1),
    tabPanel("Schädlinge", ui_page2),
    tabPanel("Pflanzengesundheit", ui_page3)
)

################  server   #################
server <- function(input, output, session) {
  server_page1(input, output, session)
  server_page2(input, output, session)
  server_page3(input, output, session)
}

################   run     #################
shinyApp(ui, server)
