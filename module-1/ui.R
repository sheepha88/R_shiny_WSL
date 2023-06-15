ui <- fluidPage(
  useShinyjs(),
  
  #HTML function 지정
    tags$head(tags$script(type = "text/javascript", 
                        HTML("function getUploadTarget(value , id) {
        
        Shiny.setInputValue(value,id, {priority: 'event'});
        
        ;}"))
    ),

    fluidRow(
        column(width = 10,
                moduleAbcUI("abc"))
        ,
        column(width = 2,
                moduleXYZUI("xyz"))
        
  
    )
    


  
  
#   tabPanel("Files",
#            titlePanel("Files Upload"),
           
#            fluidRow(
#              class = "ms-2 mt-2 mb-4",
             
#              column(
#                width = 10,
#                #import from moduleABC
#                addButton("addButton"),
#              ),
             
#              #숨겨진 업로드 & 다운로드 버튼
#              column(
#                width = 2,
               
#                fileInput( inputId = "upload_file", label = NULL) |> 
#                  tagAppendAttributes(tag = _, class = "sr-only" ),
               
#                downloadButton(outputId = "download_file", label = NULL, class = "sr-only")
#              )

#            ),
        
           
#            fluidRow(
#              class = "ms-2 mt-4 mb-3 border-top",
#              fluidRow(
#                id = "here",
#                class = "mt-4"
#              )
#            ),
#   ),
)

