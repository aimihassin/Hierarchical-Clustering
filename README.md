# Hierarchical-Clustering

This project was done for my Machine Learning course.

### Title: CATEGORISING CUSTOMER TYPE BASED ON THEIR USAGE EXPERIENCE BY USING CLUSTERING TECHNIQUES

### Objective:

* To categorize telecom user type by using unsupervised machine learning and segmentation method.
* To analyze experiment results and understand method used by each model / algorithm.
* To compare the effectiveness of algorithms used.

### What is Hierarchical Clustering?

* One of unsupervised machine learning techniques.
* Hierarchical Clustering is the computation of the proximity of two clusters. It utilises a dendogram- a tree-like outline that records the sequences of merges or   
  splits.
* Two types of Hierarchical Clustering:
  * Agglomerative clustering (Bottom-up approach):
    * Each sample is treated as a single cluster and then successively merge (or agglomerate) pairs of clusters until all clusters have been merged into a single   
      cluster.
  * Divisive clustering (top-down):
    * A single cluster of all the samples is portioned recursively into two least similar clusters until there is one cluster for each observation. The divisive 
      clustering algorithm is exactly the reverse of Agglomerative clustering.
* Steps in HC:
  * Step 1: Compute the proximity matrix
  * Step 2: Let each data point be a cluster
  * Step 3: Repeat; merge the two closest clusters and update the proximity matrix
  * Step 4: Until only a single cluster remains.

### What are the methods of HC used in this clustering?

* 4 methods of Agglomerative Hierarchical clustering technique were applied in this project;
  * Ward’s linkage:
    * Algorithm computes the sum of squared distances within the clusters and merges them to minimize it.
  * Complete linkage:
    * For each pair of clusters, the algorithm computes and merges them to minimize the maximum distance between the clusters (the distance of the farthest elements)
  * Average linkage:
    * It’s similar to complete linkage, but in this case, the algorithm uses the average distance between the pairs of clusters
  * Single linkage:
    * It separates between two groups based on their two nearest individuals (minimum distance).
    
### Description of Outcomes:

| Cluster Number | Description |
|----------------|-------------|
| 1              | Represent subscriber who have low amount of data utilization with low duration of connected session |
| 2              | Represent subscriber who have low to medium amount of data utilization and with medium of connected session |
| 3              | Represent subscriber who have medium to high amount of data utilization and with medium to high duration of connected session |

