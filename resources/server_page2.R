############### server 2 ###################

server_page2 <- function(input, output, session) {

# Initiating Objects
  tableData_p2 <- reactiveVal(
    read.csv("./resources/data_detailed.csv")
  )

  current_plant_index <- reactiveVal(1)

  selection = app_data$todo[[1]]$VIP[1]


# Funktion update Table
  update_data_p2 <- eventReactive(
    input$save_p2, {
      new_row_p2 <-
        tibble(
          id = max(tableData_p2()$id) + 1,
          time = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
          name = session$user(),
          ref = app_data$todo[[input$tour_p2]]$ref,
          pflanze = input$current_plant_p2,
          gut_oder_nicht = app_data$todo[[input$tour_p2]]$good_or_bad,
          art = app_data$todo[[input$tour_p2]]$art,
          kategorie = input$kategorie_p2,
          bemerkung = input$bemerkung_p2,
          deleted = 0
        )
      bind_rows(tableData_p2(), new_row_p2) %>%
      write.csv("./resources/data_detailed.csv", row.names = FALSE)

      tableData_p2(
        read.csv("./resources/data_detailed.csv")
      )
    }
  )

# observe and update Tour selection

  observeEvent(
    input$tour_p2, {
      updateSelectInput(
        session,
        "current_plant_p2",
        choices = app_data$todo[[input$tour_p2]]$VIP
      )
      updateRadioButtons(
        session,
        "kategorie_p2",
        choices = app_data$todo[[input$tour_p2]]$category,
        label = app_data$todo[[input$tour_p2]]$text
      )

    }
  )
# update current Plant Index
  updatePlantIndex <- function(observe, increase) {

  if (increase) {
    add_term <- 1
  } else {
    add_term <- -1
  }

  plant_index <- eventReactive(
    observe, {
      current_plant_index(
          current_plant_index() %% length(
                  app_data$todo[[input$tour_p2]]$VIP) + add_term
      )
      selection <- app_data$todo[[input$tour_p2]]$VIP[current_plant_index()]

      updateSelectInput(
        session,
        "current_plant_p2",
        selected = selection
      )
    }
  )

  return(plant_index)
}

# Observe current_plant_p2
  observeEvent(
    input$current_plant_p2, {
    if (!is.null(input$current_plant_p2)) {
      start_index <-  which(
          app_data$todo[[input$tour_p2]]$VIP == input$current_plant_p2
          )

    if (length(start_index) > 0) {
        current_plant_index(start_index)
      }
    }
  })

# Observe input save_p2
  observeEvent(
    input$save_p2, {

      update_data_p2()
      current_plant_index(
        updatePlantIndex(input$save_p2, TRUE)()
      )
    }
  )


# rendering Table
output$data_table_p2 <- DT::renderDataTable({
  DT::datatable(
    tableData_p2() %>%
    filter(deleted != 1) %>% 
    select(id, time, name, pflanze, art, kategorie, bemerkung) %>% 
    arrange(desc(row_number())),
    options = list(pageLength = 10),
    rownames = FALSE
  )
})

# download handler page 2
  output$downloadData_p2 <- downloadHandler(
    filename = function() {
      paste(
        "data_det_",
        format(Sys.time(), "%Y-%m-%d_%H-%M-%S"),
        ".csv",
        sep = ""
      )
    },
    content = function(file) {
      write.csv(
        tableData_p2(),
        file,
        row.names = FALSE,
        fileEncoding = "UTF-8"
      )
    }
  )

# delete data

observeEvent(
  input$delete_ex_p2, {
    delete_id <- process_delete_input(input$delete_p2)
    if(!is.null(delete_id)){
      data <- read.csv("./resources/data_detailed.csv")
      data$deleted[data$id %in% delete_id] <- 1
      data %>% write.csv("./resources/data_detailed.csv", row.names = FALSE)
      tableData_p2(
        read.csv("./resources/data_detailed.csv") %>% filter(deleted != 1)
      )
      updateTextInput(
        session,
        "delete_p2",
        value = ""
      )
    }
  }
)

# logout user
observeEvent(
  input$logout_p2, {
    user(NULL)
  }
)
}