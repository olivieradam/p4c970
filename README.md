# p4c970

Projet Folding at Home / COVID19

## Getting Started

Using GCP/Kubernetes to deploy and run workloads automatically in a cluster.

## Prerequisites

A GCP Account, A GCP Project, a Compute Engine VPC and Sub Network, a Cloud Router and a NAT Gateway

### Installing

* Create the cluster :

gcloud beta container clusters create cluster --zone "europe-west1-d" \
--no-enable-basic-auth --machine-type "n1-highcpu-4" --image-type "COS" \
--metadata disable-legacy-endpoints=true \
--scopes "default" \
--preemptible --num-nodes "3" --enable-stackdriver-kubernetes --enable-private-nodes \
--master-ipv4-cidr "172.16.0.0/28" --enable-ip-alias --network cloud --subnetwork lan \
--enable-intra-node-visibility --default-max-pods-per-node "110" \
--enable-master-authorized-networks \
--master-authorized-networks 192.168.0.0/16 \
--addons HorizontalPodAutoscaling --enable-autoupgrade --enable-autorepair

## Deployment


## Authors

* nostromo

