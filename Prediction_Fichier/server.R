#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(DT)

# Define server logic required to draw a histogram
function(input, output, session) {
  
  #importer le model logistique pour pouvoir l'utiliser sur toutes les datas qui sont fournies ici 
  
  model_logistique <- readRDS("C:/Users/MERCYCORPS/OneDrive - mercycorps.org/Desktop/R practice/Projet 2 Rconfig/Quarto Practice PART5 Linear Regression/Objets Stockes/model_logistique_final.rds")
  
  data <- reactiveVal() #Pour stocker les datas imported 
  
  observeEvent(input$loadData, {
    req(input$fileInput)  #s'assurer qu'un file est bien loaded 
    
    df <-read.csv(input$fileInput$datapath)
    
    #conversion de Pclass et Sex en facteurs 
    
    df$Pclass <- as.factor(df$Pclass)
    df$Sex <- factor(df$Sex, levels = c("male", "female"))
    
    data(df)
    
    #presenter les donnees sous forme de Datatable 
    output$dataTable <- renderDT({
      req(data())
      data()
      
    }, options = list(pageLength = 5)) #Limiter le nombre de lignes to print
  })
  
  
  output$prediction <- renderText({
    
    #preparation des donnees 
    #crer un data frame qui recoit les donnees car elles doivent etre prises en data frame 
    new_data <- data.frame(
      
      Pclass = as.factor(input$Pclass),
      Sex = as.factor(input$Sex),
      Age = as.numeric(input$age),
      SibSp = as.numeric(input$SibSp),
      Parch = as.numeric(input$Parch),
      Fare = as.numeric(input$Fare)
      
      
      
    )
    #valeur_preridcion
    
    prob <- predict(model_logistique, newdata = new_data, type ="response")
    
    #tester sur la valeur de la prob et retourner un resultat 
    
    pred <- ifelse(prob > 0.5, "Survivra", "Ne Survivra pas")
    
    paste(pred, "avec une probabilite de", prob)
    
  })
  
  
}
