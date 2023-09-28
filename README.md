# automations
automations for daily operations

1 - login to gcloud --> gcloud auth application-default login
2 - get project details --> gcloud config get-value project 

# GKE cluster

1 - Run the following command to retrieve the access credentials for your cluster and automatically configure kubectl:
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)