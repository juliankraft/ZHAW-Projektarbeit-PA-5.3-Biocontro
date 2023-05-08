################   ui 3     ################



ui_page3 <- fluidPage(

sidebarPanel(
    width = 4,

    h4("Erfassen einer allgemeinen Beobachtung", style = "font-weight:bold;"),

    br(),

    selectInput(
        "observation_p3",
        label = "was möchtest du erfassen?",
        choices = app_data$issue,
        selected = NULL
    ),

    br(),

    selectInput(
        "table_p3",
        label = "An welchem Tisch bist du?",
        choices = app_data$table$disp,
        selected = 1
    ),

    br(),

    tags$h5("Welche Pflanzen sind betroffen?", style = "font-weight:bold;"),

    #generate_checkbox_grid(rows_react(), cols_react()),
    uiOutput("checkbox_grid"),

    actionButton(
        "clear_p3",
        label = "clear grid"
    ),

    br(), br(),

    textInput(
          "bemerkung_p3",
          label = ("Du kannst eine Bemerkung hinzufügen:"),
          value = ""
    ),

    br(), br(),

    actionButton(
        "save_p3",
        label = "Eingabe speichern"
    )
),

mainPanel(
        titlePanel("Daten"),
        dataTableOutput("data_table_p3"),
        br(), br(),
        div(
            style = "display: flex; align-items: flex-end;",
            div(
              style = "margin-right: 10px;",
              textInput(
                inputId = "delete_p3",
                label = "Hier kannst du Einträge wieder löschen:",
                placeholder = "Bsp.: 1,4,5:9"
              )
            ),
        div(
        style = "margin-bottom: 15px;",
          actionButton(
            inputId = "delete_ex_p3",
            label = "Löschen"
          )
        )
),

        br(),
        div(
          downloadButton(
            "downloadData_p3",
            "Daten als CSV herunterladen"
          ),
        )
      )
)