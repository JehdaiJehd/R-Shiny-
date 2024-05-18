#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
#Front End 
ui <- fluidPage(
  
  h1("Bienvenue sur la first R Web App"),
  #Ajoueter une partie laterale et une partie centrale 
 
  sidebarLayout(
    sidebarPanel(
      
      #Pour notre modele de prediction de survie, nous recuperons toutes les variables qui interviennent dans notre modele
      #sauf la variable Survived, notons que les noms sont écrits de la même manière pour en faciliter les analyses 
      
      #Pclass, classe du passager 
      selectInput("Pclass", "Classe du passager", c("1", "2", "3"), NULL),
      
      #Sex, sexe du passager 
      selectInput("Sex","Quel est le genre du passager", c("male", "female"), NULL),
      
      #Age, demander l'age du passager 
      numericInput("age", "Quel est l'age du passager ?", 0, min = 0, max = 120),
      
      #SibSp, nombre de fr et srs 
      numericInput("SibSp", "Nombre de freres et soeurs ou epoux/epouses a bord", 0, min = 0, max = 8),
      
      #Parch, nombre de parents a bord 
      numericInput("Parch", "Nombre de parents/enfants a bord", 0, min = 0, max = 6),
      
      #Fare, tarif
      numericInput("Fare", "Tarif", 32, min = 0, max = 3000)
    ),
    mainPanel(
      textOutput("prediction")
    )
  ),
  
)

#End FrontEnd

#---Backend
# Define server logic required to draw a histogram
server <- function(input, output) {
    
  #importer le model logistique pour pouvoir l'utiliser sur toutes les datas qui sont fournies ici 
  
  model_logistique <- readRDS("C:/Users/MERCYCORPS/OneDrive - mercycorps.org/Desktop/R practice/Projet 2 Rconfig/Quarto Practice PART5 Linear Regression/Objets Stockes/model_logistique_final.rds")
  
  
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

# Run the application 
shinyApp(ui = ui, server = server)

#End Backend
