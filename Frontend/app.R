# Load required libraries
library(shiny)
library(shinyWidgets)
library(httr)

# UI logic
ui <- fluidPage(
  # Include the external stylesheet
  includeCSS("styles.css"),
  
  # Title of the app
  titlePanel("Image Upload and Display"),
  
  # Main panel
  mainPanel(
    # File input to upload image
    fileInput("image_upload", "Choose an image", accept = c("image/png", "image/jpeg", "image/gif")),
    
    # Flexbox container to align image and tags side by side
    div(class = "flex-container",
        # Image display
        div(class = "image-display",
            imageOutput("image_display")
        ),
        
        # Tags related to AI on the right
        div(class = "tags-container",
            h3("Tags Related to AI:"),
            tags$ul(
              style = "list-style: none; padding-left: 0;",
              textOutput("image_tags")
            ),
            # Button to accept tags
            actionButton("accept_tags", "Accept Tags"),
            # Button to reject tags
            actionButton("reject_tags", "Reject Tags")
        )
    )
  )
)

# Server logic
server <- function(input, output) {
  # Function to render the uploaded image
  observeEvent(input$image_upload, {
    respuesta <- GET("https://cadd46ylxa.execute-api.us-east-1.amazonaws.com/prod/")
    cuerpo_respuesta <- content(respuesta, "text")
    output$image_tags <- renderText({
      cuerpo_respuesta 
    })
  })
  
  output$image_display <- renderImage({
    img_path <- input$image_upload$datapath
    list(src = img_path, alt = "Uploaded image", width = "100%")
  }, deleteFile = FALSE)
  
  # Action when the "Accept Tags" button is clicked
  observeEvent(input$accept_tags, {
    # Do something with the accepted tags, e.g., save them to a database
    # You can add your own logic here
  })
  
  # Action when the "Reject Tags" button is clicked
  observeEvent(input$reject_tags, {
    # Do something when the tags are rejected, e.g., remove them or notify the user
    # You can add your own logic here
  })
}

# Run the application
shinyApp(ui, server)
