library(ggplot2)
library(scales)
library(data.table)

function(input, output) {
  
  total_counts <- reactive({
    if(input$category=="All"){
      dirpath="RData//total"
      get(load(file.path(dirpath,"all_counts.RData"),envir=.GlobalEnv))
    }
  })
  
  
  total_analysis <- reactive({
    if(input$category=="All"){
    dirpath="RData//total"
    get(load(file.path(dirpath,"analysis.RData"),envir=.GlobalEnv))
    }
  })
  
  category_counts <- reactive({
    if(input$category!="All"){
      dirpath=paste0("RData//",tolower(input$category))
      get(load(file.path(dirpath,"all_counts.RData"),envir=.GlobalEnv))
    }
  })
  category_analysis <- reactive({
    if(input$category!="All"){
      dirpath=paste0("RData//",tolower(input$category))
      get(load(file.path(dirpath,"analysis.RData"),envir=.GlobalEnv))
    }
  })
  
  output$header1 <- renderText({ 
    if(input$category!="All")
    {
      print(paste0("Showing results for category ",input$category))
    }
    else{
      total_counts()
      print(paste0("Showing results for all ",fcount," categories"))
    }
  })
  
  output$header2 <- renderText({ 
    if(input$category!="All")
    {
      print(paste0("Showing results for category ",input$category))
    }
    else{
      total_counts()
      print(paste0("Showing results for all ",fcount," categories"))
    }
  })
  
  output$header3 <- renderText({ 
    if(input$category!="All")
    {
      print(paste0("Showing results for category ",input$category))
    }
    else{
      total_counts()
      print(paste0("Showing results for all ",fcount," categories"))
    }
  })
  
  output$cat_count <- renderText({ 
    total_counts()
    print(paste0("Total categories: ",fcount))
    
  })
  
  output$vp <- renderText({ 
    if(input$category!="All")
    { category_counts()
      print(verified_purchases_count)
    }
    else{
      total_counts()
      print(total_vp)
    }
  })
  
  output$hp <- renderText({ 
    if(input$category!="All")
    {
      category_counts()
      print(helpful_reviews_count)
    }
    else{
      total_counts()
      print(total_hp)
    }
  })
  
  output$mrp <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis ()
      head(most_reviewed_product[,c(1,2,3)])
    }
    else{
      total_analysis() 
      head(most_reviewed_product[,c(1,2,3)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  
  output$mvp <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis()
      head(most_verified_product[,c(1,2,3)])
    }
    else{
      total_analysis() 
      head(most_verified_product[,c(1,2,3)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  
  output$mrc <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis()
      head(customer_with_most_reviews[,c(1,2)])
    }
    else{
      total_analysis() 
      head(customer_with_most_reviews[,c(1,2)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  output$mvc <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis()
      head(most_verified_customer[,c(1,2)])
    }
    else{
      total_analysis() 
      head(most_verified_customer[,c(1,2)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  
  output$mry <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis()
      class(year_with_most_reviews$year)<-"character"
      head(year_with_most_reviews[,c(1,2)])
    }
    else{
      total_analysis() 
      class(year_with_most_reviews$year)<-"character"
      head(year_with_most_reviews[,c(1,2)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  
  output$mvy <- renderTable({ 
    if(input$category!="All")
    {
      category_analysis()
      class(most_verified_year$year)<-"character"
      head(most_verified_year[,c(1,2)])
    }
    else{
      total_analysis() 
      class(most_verified_year$year)<-"character"
      head(most_verified_year[,c(1,2)])
    }
    
  },bordered = TRUE,spacing = 'xs',colnames=TRUE)
  
  output$stats <- renderTable({
    
    if(input$category!="All")
    {
      category_counts()
      records = data.table(" "=c("Total Reviews","Total Products","Total Customers"),"  "=c(reviews_count,product_count,customer_count))
      head(records)
    }
    else{
      total_counts()
      records = data.table(" "=c("Total Reviews","Total Products","Total Customers"),"  "=c(format(total_r),total_p,total_c))
      head(records)
    }
  },bordered = TRUE,spacing = 's',colnames=FALSE
  )
  
  output$ratings <- renderTable({
    
    if(input$category!="All")
    {
      category_analysis()
      count_5  = product_ratings[product_ratings$star_rating == 5,2]
      count_4  = product_ratings[product_ratings$star_rating  == 4,2]
      count_3  = product_ratings[product_ratings$star_rating  == 3,2]
      count_2  = product_ratings[product_ratings$star_rating  == 2,2]
      count_1  = product_ratings[product_ratings$star_rating  == 1,2]
      records = data.table("5"=count_5,"4"=count_4,"3"=count_3,"2"=count_2,"1"=count_1)
      names(records)<-c("5 stars","4 stars","3 stars","2 stars","1 star")
      head((records))
    }
    else{
      total_analysis()
      count_5  = all_r[all_r$star_rating == 5,2]
      count_4  = all_r[all_r$star_rating  == 4,2]
      count_3  = all_r[all_r$star_rating  == 3,2]
      count_2  = all_r[all_r$star_rating  == 2,2]
      count_1  = all_r[all_r$star_rating  == 1,2]
      records = data.table("5"=count_5,"4"=count_4,"3"=count_3,"2"=count_2,"1"=count_1)
      names(records)<-c("5 stars","4 stars","3 stars","2 stars","1 star")
      head((records))
    }
  },
  bordered = TRUE,spacing = 'xs',colnames=TRUE
  )
  
  output$year <- renderDataTable({
    
    if(input$category!="All")
    {
      category_analysis()
      year_reviews = year_reviews[order(year_reviews$year),]
      names=year_reviews$year
      DT::datatable(t(year_reviews$reviews) ,colnames=names,rownames=NULL,options = list(scrollX = TRUE,dom = 'tip'))
      #head((year_reviews),n=20)
    }
    else{
      total_analysis()
      year_reviews = all_y[order(all_y$year),]
      names=all_y$year
      DT::datatable(t(all_y$reviews) ,colnames=names,rownames=NULL,options = list(scrollX = TRUE,dom = 'tip'))
      #head((all_y),n=20)
    }
  }
  #,bordered = TRUE,spacing = 'xs',colnames=FALSE
  )
  
  output$ratings_plot <- renderPlot({ 
    if(input$category!="All"){
      category_analysis()
      plot_ratings = ggplot(product_ratings,aes(x=star_rating,y=count)) 
      plot_ratings = plot_ratings + labs(x="Star Ratings",y="Review count",title = "Plot of reviews by star rating") 
      plot_ratings = plot_ratings + geom_bar(stat="identity",fill="blue")
      plot_ratings = plot_ratings + scale_y_continuous(label=comma)
      plot_ratings = plot_ratings + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0))
      plot_ratings = plot_ratings + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
      plot_ratings
    }
    else{
      total_analysis()
      plot_all_ratings = ggplot(all_r,aes(x=star_rating,y=count)) + labs(title = "Plot of reviews by star rating",x="Star Ratings",y="Review count") + geom_bar(stat="identity",fill="blue") + scale_y_continuous(label=comma) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
      
      plot_all_ratings
    }
  })
  output$reviews_plot <- renderPlot({ 
    if(input$category!="All"){
      category_analysis()
      plot_year_reviews = ggplot(year_reviews,aes(x=year,y=reviews)) 
      plot_year_reviews = plot_year_reviews + labs(x="Year",y="Review count",title="Plot of reviews by Year") 
      plot_year_reviews = plot_year_reviews + geom_bar(stat="identity",fill="blue")
      plot_year_reviews = plot_year_reviews + scale_y_continuous(label=comma)
      plot_year_reviews = plot_year_reviews + scale_x_continuous(breaks=1995:2015) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) +
        theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
      plot_year_reviews
    }
    else{
      total_analysis()
      plot_all_year_reviews = ggplot(all_y,aes(x=year,y=reviews)) 
      plot_all_year_reviews = plot_all_year_reviews + labs(x="Year",y="Review count",title="Plot of reviews by Year") 
      plot_all_year_reviews = plot_all_year_reviews + geom_bar(stat="identity",fill="blue")
      plot_all_year_reviews = plot_all_year_reviews + scale_y_continuous(label=comma)
      plot_all_year_reviews = plot_all_year_reviews + scale_x_continuous(breaks=1995:2015) + theme(plot.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=20, hjust=0)) + theme(axis.title = element_text(family = "Trebuchet MS", color="#666666", face="bold", size=15)) 
      plot_all_year_reviews
      
    }
  })
  
  
  
}
