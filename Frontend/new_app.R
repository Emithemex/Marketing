library(shiny)
library(httr)

# Lista de cosas aleatorias
cosas <- c("Manzana", "Banana", "Cereza", "Durazno", "Uva")

# UI
ui <- fluidPage(
  titlePanel("Botón que muestra cosas aleatorias"),
  sidebarLayout(
    sidebarPanel(
      actionButton("boton", "Mostrar cosas aleatorias")
    ),
    mainPanel(
      textOutput("listaAleatoria"),
      actionButton("accept_tags", "Accept Tags"),
      # Button to reject tags
      actionButton("reject_tags", "Reject Tags")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$boton, {
    respuesta <- GET("https://cadd46ylxa.execute-api.us-east-1.amazonaws.com/prod/")
    cuerpo_respuesta <- content(respuesta, "text")
    print(cuerpo_respuesta)
    output$listaAleatoria <- renderText({
      cuerpo_respuesta 
    })
  })
}

# Ejecuta la aplicación
shinyApp(ui = ui, server = server)
