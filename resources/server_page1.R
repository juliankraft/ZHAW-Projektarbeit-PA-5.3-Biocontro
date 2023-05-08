############### server 1 ###################

server_page1 <- function(input, output, session) {

session$user <- reactiveVal(value = NULL)

output$info_p1 <- renderText("Diese Version des Datenerhebungstools ist zur Ansicht und zum Ausprobieren.")

observeEvent(
    input$confirm_p1, {
        # user$value <- input$name_p1
        session$user(input$name_p1)
        output$login_result <- renderText(paste("Du bist als ", session$user(), " eingelogt."))
    }
)
}
