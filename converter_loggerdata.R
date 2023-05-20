#Skript to summarize the logger data from the loggers in the lab

library(tidyverse)

filenames = dir(pattern = "txt")
log_file = tibble(filenames, logger_nr = as.numeric(str_extract(filenames, "\\d+")))

data_raw = c()
    for (i in 1:nrow(log_file)) 
    {   
        tab1 = 
            suppressWarnings(
                read_csv(filenames[i], col_names = FALSE, col_types = cols(.default = "c"), skip = 1)
            ) 
    
        tab2 = 
            tab1 %>%
                mutate(
                    table = log_file$logger_nr[i]
                ) %>%
            select(
                table,
                time = X2,
                temp = X3,
                hum = X4,
                dew = X5
            )
        data_raw <- rbind(data_raw,tab2)
    }

filename <- paste0("logger_data_", data_raw$time %>% max() %>% as.Date(), ".csv")

data_raw %>% 
    mutate(
        time = time %>% as_datetime(),
        temp = temp %>% as.double(),
        hum = hum %>% as.double(),
        dew = dew %>% as.double()
    ) %>%
    arrange(table)%>%
    write.csv(filename, row.names = FALSE)
