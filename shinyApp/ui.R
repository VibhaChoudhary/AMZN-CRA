library(DT)
category <- c("All","Apparel","Automotive","Baby","Beauty","Books_00","Books_01","Books_02","Camera",
                "Digital_Ebook_00","Digital_Ebook_01","Digital_Music","Digital_Software","Digital_Video_Games",
                "Digital_Video","Electronics","Furniture","Gift_Card","Grocery","Health_Personal_Care",
                "Home_Entertainment","Home_Improvement","Home","Jewelry","Kitchen","Lawn_And_Garden",
                "Luggage","Major_Appliances","Mobile_Apps","Mobile_Electronics","Musical_Instrument","Music",
                "Office_Products","Outdoors","Pc","Personal_Care","Pet_Products","Shoes","Software","Sports",
                "Tools","Toys","Video_Dvd","Video_Games","Video","Watches","Wireless")


fluidPage(
  
  # Application title
  titlePanel("Amazon Customer Reviews Analysis"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h4("Summary"),
     
      tableOutput("stats"),
     
      span(textOutput("cat_count"),style="color:auto;font-weight:bold"),
      hr(),
      selectizeInput("category", "Select Category",category,selected="All",multiple=F,options=NULL)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Results",
                 hr(),
                 textOutput("header"),
                 span(h4("Reviews Distribution By Star Ratings"),style="color:auto"),
                 br(),
                 tableOutput("ratings"),
                 hr(),
                 span(h4("Reviews Distribution By Year"),style="color:auto"),
                 br(),
                 DT::dataTableOutput("year"),
                 hr(),
                 span(h4("Overall Statistics"),style="color:auto"),
                 br(),
                 h5("Total verified purchases:",style ="padding-left:0px;font-weight:bold;"),
                 textOutput("vp"),
                 h5("Total helpful votes:",style ="padding-left:0px;font-weight:bold"),
                 textOutput("hp"),
                 #conditionalPanel(condition = "input.category!='All'",
                 h5("Most reviewed product:",style ="padding-left:0px;font-weight:bold"),
                # ),
                 tableOutput("mrp"),
                          #conditionalPanel(condition = "input.category!='All'",
                            h5("Product with most verified purchases:",style ="padding-left:0px;font-weight:bold"),
                         # ),
                          tableOutput("mvp"),
                          #conditionalPanel(condition = "input.category!='All'",
                            h5("Customer who made most reviews:",style ="padding-left:0px;font-weight:bold"),
                          #),
                          tableOutput("mrc"),
                          #conditionalPanel(condition = "input.category!='All'",
                            h5("Customer who made most verified purchases:",style ="padding-left:0px;font-weight:bold"),
                         # ),
                          tableOutput("mvc"),
                         # conditionalPanel(condition = "input.category!='All'",
                            h5("Year which received most reviews:",style ="padding-left:0px;font-weight:bold"),
                         # ),
                          tableOutput("mry"),
                         # conditionalPanel(condition = "input.category!='All'",
                            h5("Year in which most verified purchases were made:",style ="padding-left:0px;font-weight:bold"),
                         # ),
                          tableOutput("mvy"),
                 hr(),
                 br() 
        ),
        tabPanel("Plots",
                 hr(),
                 plotOutput("ratings_plot"),
                 hr(),
                 plotOutput("reviews_plot")
        )
      )
      #plotOutput("ratings_plot")
      
    ))
)