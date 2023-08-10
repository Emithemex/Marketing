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
      textOutput("listaAleatoria")
    )
  )
)

# Server
server <- function(input, output) {
  observeEvent(input$boton, {
    respuesta <- GET("https://cadd46ylxa.execute-api.us-east-1.amazonaws.com/prod/")
    print(respuesta)
    output$listaAleatoria <- renderText({
      sample(cosas, 5, replace = TRUE)
    })
  })
}

# Ejecuta la aplicación
shinyApp(ui = ui, server = server)
