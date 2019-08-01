## Table of contents
* [General info](#general-info)
* [Dataset](#dataset)
* [Technologies](#technologies)
* [Dataset Download](#dataset-download)
* [Analysis](#analysis)
* [Results](#results)


## General info
The goal is to perform information analysis on Amazon Customer Reviews Dataset consiting of 150+ million records and get insights such as:
-	What are the most reviewed products in different product categories?
-	What is the distribution of negative-positive reviews for each product category?
-	What are the top-rated products in different categories?
-	How many reviews were useful?
-	How is the growth of reviews over years?
</br> Analysis results displayed on RShiny app: https://vibhachoudhary.shinyapps.io/AMZN-CRA/

## Dataset
Amazon customer reviews dataset is a collection of millions of reviews made by the customers on the Amazon.com website in a period of two decades since the first review in 1995. 
The downloadable TSV files can be found [here](https://s3.amazonaws.com/amazon-reviews-pds/tsv/index.txt)
![alt text](https://raw.githubusercontent.com/VibhaChoudhary/AMZN-CRA/master/dataset.png)

The entire dataset size is ~ 75 GB. 
</br>The dataset used in the project consists of 12 columns
 customer_id, review_id, product_id, product_parent, product_title, product_category, 
star_rating, helpful_votes, total_votes, verified_purchase, review_headline, review_date
</br>The dataset size on disk is: 23GB and total records are: 150962232 (more than 150 million)


## Technologies
- R
- MySQL

## Dataset Download

Run download_data.sh to download the AMZN  dataset from the urls specified in url.txt file.
</br> Run prepare_dataset.R to unzip the .tsv files, save results in the data directory

## Analysis
The R script “perform_computation.R" performs computation on the dataset and saves the output in form of plots and RData files(used by shiny app) in the output directory. The script makes use of  “fread” from data.table package to read the .tsv file in memory and uses foreach package of R and performs the computation concurrently for all product categories.

## Results
The app make use of .RData files created by perform_computation.R and displays output in form of text, tables and plots
- Home page
![alt text](https://raw.githubusercontent.com/VibhaChoudhary/AMZN-CRA/master/home.png)
- Analysis page
![alt text](https://raw.githubusercontent.com/VibhaChoudhary/AMZN-CRA/master/analysis.png)
- Plots
![alt text](https://raw.githubusercontent.com/VibhaChoudhary/AMZN-CRA/master/plots.png)
