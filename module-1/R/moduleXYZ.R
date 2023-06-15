# ------------------------------------------------------------------------------------------------ #
# UI                                                                                               #
# ------------------------------------------------------------------------------------------------ #
moduleXYZUI <- function(id){
    ns <- NS(id)

    fluidPage(
        id = id,
        
        fluidRow(
            fileInput( inputId = ns("upload_file"), label = NULL) |> 
                 tagAppendAttributes(tag = _, class = "sr-only" )
        )
    )

}





# ------------------------------------------------------------------------------------------------ #
# server                                                                                           #
# ------------------------------------------------------------------------------------------------ #
moduleXYZServer <- function(id , clicked_Id){
    moduleServer(id , function(input , output , session){

        isolate({
            tmpDir <- "www/images"
            fileInfo <- reactiveValues()
        })
        
        observeEvent(clicked_Id(), {
            print(clicked_Id())
            req(clicked_Id()!=0L)
            shinyjs::click("upload_file")       
        })

        observeEvent(input$upload_file, {
            req(input$upload_file, clicked_Id()!=0L)
            
            if ( !dir.exists(tmpDir) ){
                dir.create(tmpDir, recursive = TRUE)
            }

            id_clicked <- clicked_Id()
            rawName <- input$upload_file$name
            fileExt <- tools::file_ext(rawName)
            tmpPath <- file.path(tmpDir, sprintf("f%03d.%s", id_clicked, fileExt))
            
            
            file.copy(
                from  = input$upload_file$datapath,
                to = tmpPath,
                overwrite = TRUE
            )

        })

    })
}

