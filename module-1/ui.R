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
)