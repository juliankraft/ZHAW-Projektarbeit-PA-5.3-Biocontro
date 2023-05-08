################   ui 2     ################

ui_page2 <- fluidPage(

    sidebarLayout(

      sidebarPanel(
        width = 3,

        h4("Erfassen eines Datensatzes", style = "font-weight:bold;"),

        br(),

        selectInput(
          "tour_p2",
          label = "Was untersuchst du?",
          choices = names(app_data$todo),
          selected = 1
        ),

        selectInput(
          "current_plant_p2",
          label = "Bei welcher Pflanze bist du?",
          choices = app_data$todo[[1]]$VIP,
          selected = NULL
        ),

        HTML(
          "Wenn du einen Eintrag speicherst wechselt diese Eingabe
          automatisch zur nächsten Pflanze in der Liste."),

        br(), br(),

        radioButtons(
          "kategorie_p2",
          label = app_data$todo[[1]]$text,
          choices = app_data$todo[[1]]$category,
          selected = 1
        ),

        textInput(
          "bemerkung_p2",
          label = ("du kannst eine Bemerkung hinzufügen"),
          value = ""
        ),

        br(), br(),

        actionButton(
          "save_p2",
          label = "Speichern -> Next",
        ),
      ),

      mainPanel(
        titlePanel("Daten"),
        dataTableOutput("data_table_p2"),
        br(), br(),
        div(
            style = "display: flex; align-items: flex-end;",
            div(
              style = "margin-right: 10px;",
              textInput(
                inputId = "delete_p2",
                label = "Hier kannst du Einträge wieder löschen:",
                placeholder = "Bsp.: 1,4,5:9"
              )
            ),
        div(
        style = "margin-bottom: 15px;",
          actionButton(
            inputId = "delete_ex_p2",
            label = "Löschen"
          )
        )
),

        br(),
        div(
          downloadButton(
            "downloadData_p2",
            "Daten als CSV herunterladen"
          )
        )
      )
    )

)
