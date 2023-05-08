server_page3 <- function(input, output, session) {

############## Initiating ##################

# Initiating Objects
  tableData_p3 <- reactiveVal(
    read.csv("./resources/data_general.csv")
  )

checked_boxes <- generate_reactive_val_grid( rows = rows_react(), cols = cols_react(), input)

# Funktion update Table
update_data_p3 <- eventReactive(
    input$save_p3, {
      checked_boxes <- generate_reactive_val_grid( rows = rows_react(), cols = cols_react(), input)
      new_row_p3 <- tibble(
          time = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
          name = session$user(),
          beobachtung = input$observation_p3,
          tisch = input$table_p3,
          pflanzen = paste(names(checked_boxes())[unlist(checked_boxes())], collapse = ", "),
          bemerkung = input$bemerkung_p3,
          deleted = 0
        ) %>%
        separate_rows(pflanzen, sep = ", ")

      new_new_row_p3 <- new_row_p3 %>%
      mutate(
        id = seq(
          max(tableData_p3()$id) + 1,
          max(tableData_p3()$id) + nrow(new_row_p3), 1
        )
      )
    bind_rows(tableData_p3(), new_new_row_p3) %>%
      write.csv("./resources/data_general.csv", row.names = FALSE)

      tableData_p3(
        read.csv("./resources/data_general.csv")
      )
     
    }
)

##############  Observing  #################
# Observe input save_p3
observeEvent(
    input$save_p3, {
      update_data_p3()
      #output$checkbox_grid <- renderUI({ generate_checkbox_grid(rows_react(), cols_react()) })
    }
)

# clear grid
observeEvent(
    input$clear_p3, {
      output$checkbox_grid <- renderUI({ generate_checkbox_grid(rows_react(), cols_react()) })
    }
)

# observe input table_p3

 rows_react <- reactiveVal(app_data$table[1,3])
 cols_react <- reactiveVal(app_data$table[1,4])

observeEvent(
    input$table_p3, {
        rows_react(app_data$table[match(input$table_p3,app_data$table$disp),3])
        cols_react(app_data$table[match(input$table_p3,app_data$table$disp),4])
    }
)

output$checkbox_grid <- renderUI({ generate_checkbox_grid(rows_react(), cols_react()) })

###############  Reacting  #################
observeEvent(
    input$observation_p3, {
        if(input$observation_p3 == "-- Hinzufügen --") {
            showModal(
                modalDialog(
                    textInput(
                        "new_issue_value",
                        label = "Neue Auswahlmöglichkeit hinzufügen:"
                    ),
                    footer = tagList(
                        actionButton("save_mod", "speichern"),
                        actionButton("cancel_mod", "verwerfen"),
                    )
                )
            )
        }
    }
)

# modal dialog new issue
observeEvent(
    input$save_mod, {
        app_data$issue <- append(input$new_issue_value, app_data$issue)
        updateSelectInput(
            session,
            "observation_p3",
            choices = app_data$issue
        )
        toJSON(app_data) %>% write("./resources/app_data.json")
        removeModal()
    }
)
observeEvent(
    input$cancel_mod, {
        removeModal()
    }
)
# download handler page 3
output$downloadData_p3 <- downloadHandler(
    filename = function() {
        paste(
            "data_alg_",
            format(Sys.time(), "%Y-%m-%d_%H-%M-%S"),
            ".csv",
            sep = ""
        )
    },
    content = function(file) {
        write.csv(
            tableData_p3(),
            file,
            row.names = FALSE,
            fileEncoding = "UTF-8"
        )
    }
)


##############  Rendering  #################

output$data_table_p3 <- DT::renderDataTable({
    DT::datatable(
      tableData_p3()  %>%
      filter(deleted != 1) %>%
      select(id, time, name, beobachtung, tisch, pflanzen, bemerkung) %>%
      arrange(desc(row_number())),
      options = list(pageLength = 10),
      rownames = FALSE
    )
  })
  
# delete data

observeEvent(
  input$delete_ex_p3, {
    delete_id <- process_delete_input(input$delete_p3)
    if(!is.null(delete_id)){
      data <- read.csv("./resources/data_general.csv")
      data$deleted[data$id %in% delete_id] <- 1
      data %>% write.csv("./resources/data_general.csv", row.names = FALSE)
      tableData_p3(
        read.csv("./resources/data_general.csv") %>% filter(deleted != 1)
      )
      updateTextInput(
        session,
        "delete_p3",
        value = ""
      )
    }
  }
)

# logout user
observeEvent(
  input$logout_p3, {
    user(NULL)
  }
)
}
