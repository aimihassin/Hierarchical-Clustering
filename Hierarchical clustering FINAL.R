#HIERARCHICAL CLUSTERING


## Load dataset

dataset = read.csv("customer_utilization_V1.0.csv")


## Checking the dataset

names(dataset) # Atributes names
str(dataset) # To check data structure
sapply(dataset, function(x) sum(is.na(x))) # To check any NA values

summary (dataset)
set.seed(786)


## Set a new dataset (reducing the observation rows)

new_dataset = dataset[c(1:20000), c(3,5)]
head(new_dataset)


## Feature Scaling

new_dataset = as.data.frame(scale(new_dataset))
summary(new_dataset)


## Plotting dendogram

d = dist(new_dataset$DOWNLOAD_GB, method = "euclidean") # To find dissimilarity matrix

par(mfrow=c(2,2))

dendogram1 = hclust(d, method = "ward.D") # hierarchical clustering using ward.D approach
plot(dendogram1, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     sub = NULL, xlab = "Download_utilisation", ylab = "Euclidean distances") 

dendogram2 = hclust(d, method = "complete") # hierarchical clustering using complete approach
plot(dendogram2, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     sub = NULL, xlab = "Download_utilisation", ylab = "Euclidean distances") 

dendogram3 = hclust(d, method = "average") # hierarchical clustering using average approach
plot(dendogram3, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     sub = NULL, xlab = "Download_utilisation", ylab = "Euclidean distances") 

dendogram4 = hclust(d, method = "single") # hierarchical clustering using single approach
plot(dendogram4, labels = NULL, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE,
     sub = NULL, xlab = "Download_utilisation", ylab = "Euclidean distances") 


## Clustering dendogram`

par(mfrow=c(2,2))

hc1 = hclust(d = dist(new_dataset$DOWNLOAD_GB, method = 'euclidean'), method = 'ward.D') # ward.D approach
y_hc1 = cutree(hc1, k=3) # Cut tree into 3 groups
plot(hc1, main = "ward.D_approach")
rect.hclust(hc1, k = 3, border = 2:6)
abline(h = 3, col = 'red')

hc2 = hclust(d = dist(new_dataset$DOWNLOAD_GB, method = 'euclidean'), method = 'complete') # complete approach
y_hc2 = cutree(hc2, k=3) 
plot(hc2, main = "complete_approach")
rect.hclust(hc2, k = 3, border = 2:6)
abline(h = 3, col = 'red')

hc3 = hclust(d = dist(new_dataset$DOWNLOAD_GB, method = 'euclidean'), method = 'average') # average approach
y_hc3 = cutree(hc3, k=3) 
plot(hc3, main = "average_approach")
rect.hclust(hc3, k = 3, border = 2:6)
abline(h = 3, col = 'red')

hc4 = hclust(d = dist(new_dataset$DOWNLOAD_GB, method = 'euclidean'), method = 'single') # single approach
y_hc4 = cutree(hc4, k=3) 
plot(hc4, main = "single_approach")
rect.hclust(hc4, k = 3, border = 2:6)
abline(h = 3, col = 'red')

title(main = "Cluster Dendogram",outer = TRUE)


## To visualise dendogram with different coloured branches

suppressPackageStartupMessages(library(dendextend))

par(mfrow=c(2,2))

hc_obj1 <- as.dendrogram(hc1)
hc_dend1 <- color_branches(hc_obj1, h = 3)
plot(hc_dend1, main = "ward.D_approach")

hc_obj2 <- as.dendrogram(hc2)
hc_dend2 <- color_branches(hc_obj2, h = 3)
plot(hc_dend2, main = "complete_approach")

hc_obj3 <- as.dendrogram(hc3)
hc_dend3 <- color_branches(hc_obj3, h = 3)
plot(hc_dend3, main = "average_approach")

hc_obj4 <- as.dendrogram(hc4)
hc_dend4 <- color_branches(hc_obj4, h = 3)
plot(hc_dend4, main = "single_approach")

title(main = "Cluster Dendogram",outer = TRUE)


## To count number of observations in each cluster

suppressPackageStartupMessages(library(dplyr))

new_dataset_cl1 <- mutate(new_dataset, cluster = y_hc1)
count(new_dataset_cl1,cluster)

new_dataset_cl2 <- mutate(new_dataset, cluster = y_hc2)
count(new_dataset_cl2,cluster)

new_dataset_cl3 <- mutate(new_dataset, cluster = y_hc3)
count(new_dataset_cl3,cluster)

new_dataset_cl4 <- mutate(new_dataset, cluster = y_hc4)
count(new_dataset_cl4,cluster)


## To visualise the result in a scatter plot

library(factoextra)
library(ggplot2)
library(grid)
library(gridExtra)

c1 = fviz_cluster(list(data = new_dataset_cl1, cluster = y_hc1, ellipse.type = "convex")) + ggtitle("ward.D_approach")

c2 = fviz_cluster(list(data = new_dataset_cl2, cluster = y_hc2, ellipse.type = "convex")) + ggtitle("complete_approach")

c3 = fviz_cluster(list(data = new_dataset_cl3, cluster = y_hc3, ellipse.type = "convex")) + ggtitle("average_approach")

c4 = fviz_cluster(list(data = new_dataset_cl4, cluster = y_hc4, ellipse.type = "convex")) + ggtitle("single_approach")

grid.arrange(c1, c2, c3, c4, ncol = 2, nrow = 2, top = textGrob("Cluster Plot",gp=gpar(fontsize=20,font=3)))


## To analyse the trend

library(ggplot2)
library(grid)
library(gridExtra)


p1 = ggplot(new_dataset_cl1, aes(x=new_dataset$DOWNLOAD_GB , y = new_dataset$DURATION_SEC, color = factor(cluster))) + geom_point() + labs(x = "Total_utilisation", y = "Duration") + ggtitle("ward.D_approach")

p2 = ggplot(new_dataset_cl2, aes(x=new_dataset$DOWNLOAD_GB , y = new_dataset$DURATION_SEC, color = factor(cluster))) + geom_point() + labs(x = "Total_utilisation", y = "Duration") + ggtitle("complete_approach")

p3 = ggplot(new_dataset_cl3, aes(x=new_dataset$DOWNLOAD_GB , y = new_dataset$DURATION_SEC, color = factor(cluster))) + geom_point() + labs(x = "Total_utilisation", y = "Duration") + ggtitle("average_approach")

p4 = ggplot(new_dataset_cl4, aes(x=new_dataset$DOWNLOAD_GB , y = new_dataset$DURATION_SEC, color = factor(cluster))) + geom_point() + labs(x = "Total_utilisation", y = "Duration") + ggtitle("single_approach")

grid.arrange(p1, p2, p3, p4, ncol = 2, nrow = 2, top = textGrob("Scatter Plot",gp=gpar(fontsize=20,font=3)))


## To visualise the results in cluster

library(cluster)
par(mfrow=c(2,2))

clusplot_1 <- clusplot(new_dataset_cl1,
                       y_hc1,
                       lines = 0,
                       shade = TRUE,
                       color = TRUE,
                       labels= 2,
                       plotchar = FALSE,
                       span = TRUE,
                       main = paste('ward.D_approach'),
                       xlab = 'Total_utilisation',
                       ylab = 'Duration')

clusplot_2 <- clusplot(new_dataset_cl2,
                       y_hc2,
                       lines = 0,
                       shade = TRUE,
                       color = TRUE,
                       labels= 2,
                       plotchar = FALSE,
                       span = TRUE,
                       main = paste('complete_approach'),
                       xlab = 'Total_utilisation',
                       ylab = 'Duration')

clusplot_3 <- clusplot(new_dataset_cl3,
                       y_hc3,
                       lines = 0,
                       shade = TRUE,
                       color = TRUE,
                       labels= 2,
                       plotchar = FALSE,
                       span = TRUE,
                       main = paste('average_approach'),
                       xlab = 'Total_utilisation',
                       ylab = 'Duration')

clusplot_4 <- clusplot(new_dataset_cl4,
                       y_hc4,
                       lines = 0,
                       shade = TRUE,
                       color = TRUE,
                       labels= 2,
                       plotchar = FALSE,
                       span = TRUE,
                       main = paste('single_approach'),
                       xlab = 'Total_utilisation',
                       ylab = 'Duration')

title(main = "Cluster of Customer Utilisation",outer = TRUE)

