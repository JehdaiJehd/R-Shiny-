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

library(DT)

#Front End 
ui <- dashboardPage(
  dashboardHeader(title = "Prediction de la Survie sur le Titanic"),
  
  
  #Les Menus du sidebar
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Importation des Datas", tabName = "ImportCSV", icon = icon("file-csv")),
      menuItem("Afficher le CSV", tabName = "affichage", icon = icon("table")),
      menuItem("Prediction", tabName = "Prediction")
    )
  ),
  
  
  
  
  dashboardBody(
    #Definition des contenus de page ou des nots items definis dans le haut 
    
    tabItems(
      tabItem(tabName = "ImportCSV", 
              
              #trouver le code et la documentation sur Shiny Post Galery pour avoir la doc des =nts elements 
              fileInput("fileInput", "Choisir un fichier CSV", 
                        accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                        actionButton("loadData", "Charger les Datas")),
      
      tabItem(tabName = "affichage", DTOutput("dataTable")),
            
              
      
      tabItem(tabName = "Prediction", 
              h2("Le Resultat de la prediction"), 
              textOutput("prediction")
      )
    )
  )
)

#End FrontEnd
