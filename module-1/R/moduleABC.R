# dynamic button gereration

# ------------------------------------------------------------------------------------------------ #
# UI (henry)                                                                                       #
# ------------------------------------------------------------------------------------------------ #
moduleAbcUI <- function(id){
    ns <- NS(id)
    fluidPage(
        id = id,
        fluidRow(
            tags$h4("Files Upload")
        ),

        fluidRow(
            actionButton(
                inputId = ns("add"),
                label = "Add",
                icon = icon("plus" , class = "me-1"),
                class="btn btn-outline-success me-1",
                width = "100px"
            )
        ),

        fluidRow(
            id = ns("here") # important for consistency
        )
    
    )

    
}

# ------------------------------------------------------------------------------------------------ #
# server (henry)                                                                                   #
# ------------------------------------------------------------------------------------------------ #
moduleAbcServer <- function(id){
    moduleServer(id , function(input , output , session){
        ns <- session$ns
        isolate({
          fileNum <- reactiveVal(0L)
          retVal <- reactiveVal(0L)
        })

        addNewFile <- function(wrap_id, i){ # utility function inside module
            # ui generation
            newFileUI <- fluidRow(
                id = ns(paste0("addFile_", i)),
                column(
                    width = 1,
                    tags$h4(i)
                ),
                
                column(
                    width = 3,
                    class = "align-self-center",
                    actionButton(
                        inputId = ns(paste0("upload_", i)) ,
                        label = "UPLOAD",
                        class = "refresh-target",
                        onclick = glue("getUploadTarget(\"{ns('uploadInput_ID')}\", this.id)"),
                        style = "margin-top: 25px"
                    )
                ),
            )
            # add the generated ui to the target
            insertUI(
                selector = paste0("#", wrap_id),
                where = "beforeEnd",
                ui = newFileUI
            )
        }

        observeEvent(input$add, {
            # add a new file row
            fileNum(fileNum()+1L)
            addNewFile(wrap_id = ns("here"), i = fileNum())
        })


        observeEvent(input$uploadInput_ID, {            
            id_int <- strsplit(x = input$uploadInput_ID, split = "_", fixed = TRUE)[[1L]][2L]  |> 
                as.integer()
            retVal(id_int)
        })

        #module server 내에서 값 return
        return( retVal )

    })
}







# ------------------------------------------------------------------------------------------------ #
# UI                                                                                               #
# ------------------------------------------------------------------------------------------------ #

# add actionbutton-------------------------------------------------------------------------------------------- #
addButton <- function(id){
    ns <- NS(id)

    actionButton(inputId = ns("add"),
                label = "ADD",
                icon = icon("plus" , class = "me-1"),
                class="btn btn-outline-success me-1",
                width = "100px")
}   


# add newline ------------------------------------------------------------------------------------ #
addNewFile <- function(id , wrap_id, i){

    ns <- NS(id)


    newFileUI <- fluidRow(
        id = paste0("addFile_",i),
        
        column(
        width = 1,
        tags$h4(i)
        ),
        
        column(
        width = 3,
        class = "align-self-center",
        actionButton(inputId = ns(paste0("upload_", i)) ,
                    label = "UPLOAD",
                    class = "refresh-target",
                    onclick = glue("getUploadTarget(\"{ns('uploadInput_ID')}\", this.id)"),
                    style = "margin-top: 25px"
        )
        ),
    )
    
    insertUI(
        selector = paste0("#", wrap_id),
        where = "beforeEnd",
        ui = newFileUI
    )
}


# ------------------------------------------------------------------------------------------------ #
# server                                                                                           #
# ------------------------------------------------------------------------------------------------ #

# add line --------------------------------------------------------------------------------------- #
addLine <- function(id){
    moduleServer(id , function(input , output , session){

        ns <- session$ns

        isolate({
            fileNum <- reactiveVal(0L)
        })

        # observe({
        #     cat("local server\n")
        #     print(input$uploadInput_ID)
        # })

        observeEvent(input$add , {
            req(input$add)
            fileNum(fileNum()+1L)
            addNewFile(id = id , wrap_id = "here" , i=fileNum())
        })
    })
}