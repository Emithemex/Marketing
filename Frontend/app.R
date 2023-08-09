# Load required libraries
library(shiny)
library(shinyWidgets)

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
              tags$li("Artificial Intelligence"),
              tags$li("Machine Learning"),
              tags$li("Neural Networks"),
              tags$li("Deep Learning"),
              tags$li("Natural Language Processing"),
              tags$li("Computer Vision"),
              tags$li("Data Science"),
              tags$li("Robotics"),
              tags$li("Automation"),
              tags$li("Ethics in AI")
            ),
            # Button to accept tags
            actionButton("accept_tags", "Accept Tags")
        )
    )
  )
)

# Server logic
server <- function(input, output) {
  # Function to render the uploaded image
  output$image_display <- renderImage({
    if (is.null(input$image_upload)) {
      return(NULL)
    }
    img_path <- input$image_upload$datapath
    list(src = img_path, alt = "Uploaded image", width = "100%")
  }, deleteFile = FALSE)
  
  # Action when the "Accept Tags" button is clicked
  observeEvent(input$accept_tags, {
    # Do something with the accepted tags, e.g., save them to a database
    # You can add your own logic here
  })
}

# Run the application
shinyApp(ui, server)
