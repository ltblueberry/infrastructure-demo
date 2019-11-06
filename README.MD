# Infrastructure Demo
It's a demo project where I learn new tools and improve my skills.
I use my [dummy project](https://github.com/ltblueberry/dummy-node-mongo) as deployment project.

## **simple-deploy** directory
It's the first directory of this project. It contains of several simple scripts
* **install_nodejs.sh** - Install NodeJS 13.x
* **install_mongodb.sh** - Install MongoDB latest
* **deploy.sh** - Download project, install dependencies and run application

The application runs at 3000 port.

I mannualy created VM instance at GCP, machine type **f1-micro**, image **ubuntu-1604-xenial**, network tag **dummy-server**.

Also I added Firewall rule that opens 3000 port - type **Ingress**, targets **dummy-server**, filters **IP ranges: 0.0.0.0/0**, protocols/ports **tcp: 3000**, action **Allow**.

Connect to instance via SSH and execute scripts.

Application is running, you can check it with **<instance_ip_address>:3000**

Added new scripts:
* **startup.sh** - Combine commands from three base scrpits (see above)
* **create-vm.sh** - Create gcloud compute instance with startup script
* **create-firewall-rule.sh** - Create Firewall rule to allow all incoming traffic on TCP port 3000 for "dummy-server" taged instances

## **packer** directory
It's the second directory of this project. It contains next files and directories
* **scripts** directory - Contains 3 scripts from **simple-deploy** step, but without **sudo** command
* **base.json** - Fry Image template, installs NodeJS 13.x and MongoDB latest, based on ubuntu-1604-lts
* **base_with_params.json** - This template is same as **base.json** but with user variables. Example of variables usage
* **variables.json.example** - Example of variables file for **base_with_params.json**
* **immutable.json** - Bake Image template, download dummy project and run the application, based on fry image
* **create-nodejs-vm.sh** - Script that creates gcloud compute instance from Baked Image

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

