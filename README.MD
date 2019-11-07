# Infrastructure Demo
It's a demo project where I learn new tools and improve my skills.
I use my [dummy project](https://github.com/ltblueberry/dummy-node-mongo) as deployment project. **The application runs at 3000 port.**

## Dependencies
* [gcloud](https://cloud.google.com/sdk/gcloud/)
* [Packer](https://www.packer.io)
* [Terraform](https://www.terraform.io)

## **simple-deploy**
It's the first directory of this project. It contains of several simple scripts:
* **install_nodejs.sh** - Install NodeJS 13.x
* **install_mongodb.sh** - Install MongoDB latest
* **deploy.sh** - Download project, install dependencies and run application

**This step needs ssh-key in metadata for `appuser` user**. I added it manually via GUI.

I mannualy created VM instance at GCP, machine type **f1-micro**, image **ubuntu-1604-xenial**, network tag **dummy-server**.
Also I added Firewall rule that opens 3000 port - type **Ingress**, targets **dummy-server**, filters **IP ranges: 0.0.0.0/0**, protocols/ports **tcp: 3000**, action **Allow**.

Connect to instance via SSH and execute scripts.
Application is running, you can check it with **<instance_ip_address>:3000**

Added new scripts:
* **startup.sh** - Combine commands from three base scrpits (see above)
* **create-vm.sh** - Create gcloud compute instance with startup script
* **create-firewall-rule.sh** - Create Firewall rule to allow all incoming traffic on TCP port 3000 for "dummy-server" taged instances 

**Conclusion**
Firstly I prepared scripts to install all packages that I need. Then I created gcloud compute instance via GUI. Created firewall rule. Then I connected to instance via SSH and executed scripts.

But then I made startup script, install and authorized in **gcloud**, made script for instance and rule creating and executed them. 

## **packer**
It's the second directory of this project. It contains next files and directories.
* **scripts** directory - Contains 3 scripts from **simple-deploy** step, but without **sudo** command
* **base.json** - Fry Image template, installs NodeJS 13.x and MongoDB latest, based on ubuntu-1604-lts
* **base_with_params.json** - This template is same as **base.json** but with user variables. Example of variables usage
* **variables.json.example** - Example of variables file for **base_with_params.json**
* **immutable.json** - Bake Image template, download dummy project and run the application, based on fry image
* **create-nodejs-vm.sh** - Script that creates gcloud compute instance from Baked Image

**This step still needs ssh-key in metadata for `appuser` user**. I kept it from previous step.

**variables.json.example** replace with **variables.json** with your values

To check are templates valid execute next commands
```
  packer validate base.json 
  packer validate -var-file=variables.json base_with_params.json
  packer validate immutable.json 
  
  Output must be:
  Template validated successfully.
```

To create Fry and Bake images execute next commands
```
packer build base.json 
packer build immutable.json
```

To create instance from Bake image execute next script
```
./create-nodejs-vm.sh
```

**Conclusion**
I made several Packer templates, built them and got images, that i can use via **GUI** or `gcloud compute instance create` command. I made script that create gcloud compute instance from my Bake image.


## **terraform**
It's the third directory of this project. It contains next files and directories
* **main.tf** - Demo gcloud infrastructure
* **outputs.tf** - Output variables, contains external instance ip address
* **variables.tf** - Input variables
* **terraform.tfvars.example** - Example of variables file
* **files** directory - Contains **deploy.sh** script for gcloud compute instanse provisioner

> Files **terraform.tfstate**, **terraform.tfstate.backup** are very important, cause they keep your current and backup cloud state. They added to .gitignore in this repo, but you should keep them somewhere out of repo

**This step does not need ssh-key in metadata for `appuser` user**. I removed it. Now it will be added by Terraform.

**terraform.tfvars.example** replace with **terraform.tfvars** with your values

To init terraform **provider** execute next command in **terraform** directory
```
terraform init
```

To see what will be changed since last state execute next command
```
terraform plan
```

To apply changes execute next command
```
terraform apply
```

To see some info about instance (for example external ip address) you can watch  **terraform.tfstate** file or execute next command
```
terraform show | grep assigned_nat_ip
```
But it's not so comfortable, so I made output variable.
To see all outputs variable execute next command
```
terraform output
```
Or you can see output variable by executing command like that
```
terraform output your_variable
```

After `terraform apply` command you can check application running with **<instance_ip_address_from_output_variable>:3000**

**Conclusion**
I made terraform infrastructure for my gcloud, where I create Firewall rule; create compute instance from my Fry image, maded via Packer; add SSH-key to appuser; excute deploy.sh script remotely.

## **terraform-extended**
Another terraform example, but i decided to separate db and app to different instances. I made directory **packer-fry-template** and created **fry.json** template to use it with different var-files to make fry images with NodeJS and MongoDB.
Make images with next commands
```
packer build -var "project_id=infra-258109" -var-file=mongo-variables.json fry.json 
packer build -var "project_id=infra-258109" -var-file=nodejs-variables.json fry.json 
```

Directory **terraform-extended** contains of next subdirectories
* **modules** - I made **app**, **db** and **vpc** modules
* **prod** - "Production" environment, contains of modules
* **stage** - "Staging" environment, contains of modules

Execute `terraform init` in env subdirectory and then `terraform apply`.
To import modules execute `terraform get`.

**Conclusion**
I learned how to deal with modules and reuse modules. **I deleted script provisioners** to replace them with **ansible provisioners** in future.
