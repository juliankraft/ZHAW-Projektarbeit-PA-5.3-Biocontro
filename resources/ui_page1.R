################   ui 1     ################

ui_page1 <- fluidPage(

    sidebarLayout(

        sidebarPanel(
            width = 3,
            h4("Name", style = "font-weight:bold;"),

            br(),

            textInput(
                "name_p1",
                label = "Gib deinen Namen ein:",
            ),
            actionButton(
                "confirm_p1",
                label = "Bestätigen"
            ),
            br(), br(),
            verbatimTextOutput("login_result")
        ),

        mainPanel(
            textOutput("info_p1"),
            titlePanel("Situationsplan Gewächshaus"),
            tags$img(src = "./resources/plan_lab.jpg", width = "70%")
        )
    )
)
