# Terraform AKS Helm Prometheus Grafana

## Description

This project is designed to simplify the deployment of an Azure Kubernetes Service (AKS) cluster using Terraform. It automates the process of setting up the cluster and installs Prometheus Server on it using Helm charts. The Prometheus Server is configured to interact with the Kubernetes API and nodes, leveraging auto-discovery to collect kube state metrics. It also integrates Grafana to create dashboards for observability.

To get started with this project instructions are provided for using Docker containers exclusively to implement the entire solution.

The `kube_manifest` directory contains a collection of Kubernetes manifests that can be easily applied to the AKS cluster. These manifests include configurations for deploying a sample Nginx server, setting up Horizontal Pod Autoscaling, and configuring a Prometheus load balancer for exposing it to the public, enabling user-friendly access to its UI.

### Dashboards:
Within Grafana, you have the option to import the pre-configured dashboard labeled `1000` which offers a default setup for monitoring Prometheus resources. You can also create and customize your own dashboards to suit specific needs.

## Usage

```
# Pull Docker Images
docker pull alpine/helm
docker pull hashicorp/terraform

# Change directory to terraform directory
cd terraform

# Terraform running Docker
# Initialize Terraform locally
docker run --rm -it -v ${PWD}:/data -w /data hashicorp/terraform:latest init
# Plan Terraform locally
docker run --rm -it -v ${PWD}:/data -w /data hashicorp/terraform:latest plan
# Apply Terraform locally
docker run --rm -it -v ${PWD}:/data -w /data hashicorp/terraform:latest apply


# Helm running Docker
# Adding "prometheus-community" to Helm repositories
docker run -it --rm -v ${PWD}:/apps -w /apps -v ~/.kube:/root/.kube -v ${PWD}/.helm:/root/.helm -v ${PWD}/.config/helm:/root/.config/helm -v ${PWD}/.cache/helm:/root/.cache/helm alpine/helm:latest repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update charts and repos of Helm
docker run -it --rm -v ${PWD}:/apps -w /apps -v ~/.kube:/root/.kube -v ${PWD}/.helm:/root/.helm -v ${PWD}/.config/helm:/root/.config/helm -v ${PWD}/.cache/helm:/root/.cache/helm alpine/helm:latest repo update

# Install prometheus
docker run -it --rm -v ${PWD}:/apps -w /apps -v ${HOME}/.kube/config:/root/.kube/config -v ${PWD}/.helm:/root/.helm -v ${PWD}/.config/helm:/root/.config/helm -v ${PWD}/.cache/helm:/root/.cache/helm alpine/helm:latest install prometheus prometheus-community/prometheus

# [OPTIONAL] Create a Load Balancer for Prometheus
cd kube_manifests
kuebctl apply -f ./prometheus-lb.yml

```