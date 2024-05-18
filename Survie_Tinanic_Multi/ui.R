#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

library(shinydashboard)

#Front End 
ui <- dashboardPage(
  dashboardHeader(title = "Prediction de la Survie sur le Titanic"),
  
  
  #Les Menus du sidebar
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs", tabName = "Inputs"),
      menuItem("Prediction", tabName = "Prediction")
    )
  ),
  
  
  
  
  dashboardBody(
    #Definition des contenus de page ou des nots items definis dans le haut 
    
    tabItems(
      tabItem(tabName = "Inputs", 
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
      tabItem(tabName = "Prediction", 
              h2("Le Resultat de la prediction"), 
              textOutput("prediction")
              )
    )
  )
)

#End FrontEnd
