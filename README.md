# Self-Signed-Certificates Terraform Module 

This Self-Signed-Certificates Terraform module aims to deploy the [self-signed-certificates charm](https://charmhub.io/self-signed-certificates?channel=latest/beta) via Terraform.

## Getting Started

### Install requirements

The following software and tools needs to be installed and should be running in the local environment.

- `microk8s`
- `juju 3.x`
- `terrafom`

Install Microk8s and enable storage add-on:

```console
sudo snap install microk8s --channel=1.27-strict/stable
sudo usermod -a -G snap_microk8s $USER
newgrp snap_microk8s
sudo microk8s enable hostpath-storage
```

Install Juju:

```console
sudo snap install juju --channel=3.1/stable
```

Install Terraform:

```console
sudo snap install --classic terraform
```

### Bootstrap the Juju using Microk8s and create a model to deploy Terraform module

Bootstrap Juju Controller:

```console
juju bootstrap microk8s
```

Add Juju model named `test`:

```console
juju add model test
```

### Deploy Self-Signed-Certificates Charm using Terraform

Initialise the provider:

```console
terraform init
```

Customize the configuration inputs under `terraform.tfvars` file according to requirement. Make sure that given `model-name` exists.

Sample contents of `terraform.tfvars` file:

```yaml
model_name  ="test"
```

Run Terraform Plan by providing var-file:

```console
terraform plan -var-file="terraform.tfvars" 
```

Deploy the resources, skip the approval

```console
terraform apply -auto-approve 
```

### Check the Output

Run `juju switch <juju model>` to switch to the target Juju model and observe the status of the application.

```console
juju status
```

The output should be similar to the following:

```console
Model       Controller          Cloud/Region        Version  SLA          Timestamp
test  microk8s-localhost  microk8s/localhost  3.1.7    unsupported  15:28:02+03:00

App      Version                   Status  Scale  Charm                     Channel  Rev  Address        Exposed  Message
self-signed-certificates           active       1  self-signed-certificates  beta      57  10.152.183.220  no      

Unit                         Workload  Agent  Address      Ports  Message
self-signed-certificates/0*  active    idle   10.1.146.57 
```

### Clean up 

Remove the application:

```console
terraform destroy -auto-approve
```

