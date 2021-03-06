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
  span(paste0("Analysis is based on the dataset provided by Amazon "),
              a("here",href="https://s3.amazonaws.com/amazon-reviews-pds/readme.html",
                target="_blank"
              )),
  hr(),
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
        tabPanel("Statistics",
                 br(),
                 textOutput("header1"),
                 hr(),
                 h5("Number of reviews that came from verified purchases:",style ="padding-left:0px;font-weight:bold;"),
                 textOutput("vp"),
                 h5("Number of reviews that were voted helpful by customers:",style ="padding-left:0px;font-weight:bold"),
                 textOutput("hp"),
                 hr(),
                 span(h4("Reviews Distribution By Star Ratings"),style="color:auto"),
                 br(),
                 tableOutput("ratings"),
                 hr(),
                 span(h4("Reviews Distribution By Year"),style="color:auto"),
                 br(),
                 DT::dataTableOutput("year"),
                 hr(),
                 br()
                 
        ),
        tabPanel("Analysis",
                 br(),
                 textOutput("header2"),
                 hr(),
                 #conditionalPanel(condition = "input.category!='All'",
                 h5("Most reviewed product:",style ="padding-left:0px;font-weight:bold"),
                 # ),
                 tableOutput("mrp"),
                 #conditionalPanel(condition = "input.category!='All'",
                 h5("Product with most verified purchases:",style ="padding-left:0px;font-weight:bold"),
                 # ),
                 tableOutput("mvp"),
                 hr(),
                 #conditionalPanel(condition = "input.category!='All'",
                 h5("Customer who made most reviews:",style ="padding-left:0px;font-weight:bold"),
                 #),
               
                 tableOutput("mrc"),
                 #conditionalPanel(condition = "input.category!='All'",
                 h5("Customer who made most verified purchases:",style ="padding-left:0px;font-weight:bold"),
                 # ),
                 tableOutput("mvc"),
                 # conditionalPanel(condition = "input.category!='All'",
                 hr(),
                 h5("Year in which most reviews were made:",style ="padding-left:0px;font-weight:bold"),
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
                 br(),
                 textOutput("header3"),
                 hr(),
                 plotOutput("ratings_plot"),
                 hr(),
                 plotOutput("reviews_plot")
        )
      )
    ))
)