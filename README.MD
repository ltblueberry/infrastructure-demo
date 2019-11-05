# Infrastructure Demo
It's a demo project where I learn new tools and improve my skills.
I use my [dummy project](https://github.com/ltblueberry/dummy-node-mongo) as deployment project.

### branch **simple-deploy**
It's a first branch of this project. It contains of 3 simple scripts
* **install_nodejs.sh** - Install NodeJS 13.x
* **install_mongodb.sh** - Install MongoDB latest
* **deploy.sh** - Download project, install dependencies and run application

The application runs at 3000 port.

I mannualy created VM instance at GCP, machine type **f1-micro**, image **ubuntu-1604-xenial**, network tag **dummy-server**.

Also I added Firewall rule that opens 3000 port - type **Ingress**, targets **dummy-server**, filters **IP ranges: 0.0.0.0/0**, protocols/ports **tcp: 3000**, action **Allow**.

Connect to instance via SSH and execute scripts.

Application is running, you can check it with **<instance_ip_address>:3000**
