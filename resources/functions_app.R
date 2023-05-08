generate_checkbox_grid <- function(rows, cols) {
  # Create an empty list to store the checkbox inputs
  checkbox_list <- list()

  # Add the row of titles
  set_width <- 1
  title_row <- list(column(width = set_width),
                    lapply(LETTERS[1:cols], function(x) {
                      column(width = set_width, h4(x))
                    }))
  checkbox_list[[1]] <- fluidRow(title_row)

  # Loop through each row and column and create a checkboxInput with a custom ID
  for (i in 1:rows) {
    row_id <- i
    checkbox_row <- list(column(width = set_width, h4(i)))
    for (j in 1:cols) {
      col_id <- LETTERS[j]
      checkbox_id <- paste0(col_id, row_id)
      checkbox <- checkboxInput(checkbox_id, "")
      checkbox_row[[j+1]] <- column(width = set_width, checkbox)
    }
    checkbox_list[[i+1]] <- fluidRow(checkbox_row)
  }

  # Combine the checkbox inputs into a single UI element
  do.call(fluidPage, checkbox_list)
}

generate_reactive_val_grid <- function(rows, cols,input = input) {
  reactive({
    boxes <- list()
    for (j in 1:cols) {
      for (i in 1:rows) {
        id <- paste0(LETTERS[j], i)
        if (input[[id]]) {
          boxes[[id]] <- TRUE
        } else {
          boxes[[id]] <- FALSE
        }
      }
    }
    boxes
  })
}

process_delete_input <- function(input_string) {
  split_input <- strsplit(input_string, ",")[[1]]

  all_numbers <- c()

  for (element in split_input) {
    if (grepl(":", element)) {
      range <- as.integer(unlist(strsplit(element, ":")))
      all_numbers <- c(all_numbers, seq(range[1], range[2]))
    } else {
      all_numbers <- c(all_numbers, as.integer(element))
    }
  }

  return(paste(sort(unique(all_numbers)), collapse = ", "))
}