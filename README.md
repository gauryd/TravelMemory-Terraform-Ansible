# TravelMemory — MERN Application Deployment Using Terraform and Ansible

## Project Overview

This project demonstrates the deployment of the **TravelMemory MERN stack application on Amazon Web Services (AWS)** using Terraform for infrastructure provisioning and Ansible for configuration management and application deployment.

The application allows users to add and view travel experiences. The frontend is served through Nginx, the backend runs on Node.js and Express, and MongoDB stores application data on a separate private EC2 instance.

## Project Links

- **GitHub Repository:** https://github.com/gauryd/TravelMemory-Terraform-Ansible
- **Deployed Application:** http://13.207.194.169
- **AWS Region:** `ap-south-1` (Mumbai)

## Technology Stack

| Technology | Purpose |
|---|---|
| React | Frontend user interface |
| Node.js | Backend runtime |
| Express.js | REST API |
| MongoDB | Database |
| Nginx | Frontend hosting and reverse proxy |
| Terraform | AWS infrastructure provisioning |
| Ansible | Server configuration and deployment |
| AWS EC2 | Application and database servers |
| AWS VPC | Network isolation |
| systemd | Backend service management |
| Git and GitHub | Version control and source code hosting |

## Architecture

The application uses a two-tier EC2 architecture.

1. **Public Web Server:** Runs Nginx, the React frontend, and the Node.js/Express backend.
2. **Private Database Server:** Runs MongoDB with authentication enabled.
3. **Networking:** The web server communicates with MongoDB through the private VPC network.
4. **Security Groups:** Restrict access to the application and database ports.
5. **Infrastructure Automation:** Terraform provisions the infrastructure, while Ansible configures the servers and deploys the application.

### Request Flow

```text
User Browser
     |
     | HTTP
     v
Public EC2 Instance
     |
     +---- Nginx
     |       |
     |       +---- React Frontend
     |       |
     |       +---- API Requests
     |                    |
     |                    v
     |             Node.js / Express
     |               Port 3001
     |                    |
     |                    | Private VPC Network
     |                    v
     +------------ Private EC2 Instance
                           |
                           v
                       MongoDB
                       Port 27017
```

## Repository Structure

```text
TravelMemory-Terraform-Ansible/
├── ansible/
│   ├── ansible.cfg
│   └── playbooks/
│       ├── database.yml
│       ├── deploy.yml
│       └── web.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
├── app-reference
└── .gitignore
```

Sensitive inventory and database variable files are intentionally excluded from version control. Configure your own inventory and secrets before running the playbooks.

## Prerequisites

Install or configure the following before deployment:

- AWS account with appropriate permissions
- AWS CLI
- Terraform
- Ansible
- SSH key pair for EC2 access
- Git
- Access to the TravelMemory application source repository

## Deployment Steps

### 1. Provision AWS Infrastructure with Terraform

Navigate to the Terraform directory:

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

Review the Terraform plan before applying changes. Save the output values required by Ansible.

### 2. Configure Ansible

Configure the Ansible inventory with the web server and private database server details.

Ensure SSH access to the private database instance works through the web instance or another secure management path.

Store database credentials securely using Ansible Vault or an approved secrets manager. Do not commit passwords or private keys to GitHub.

### 3. Configure the Database

Run the database playbook after reviewing its variables and settings:

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbooks/database.yml --ask-vault-pass
```

The database must use authentication and accept connections only from authorized private network sources.

### 4. Configure the Web Server

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbooks/web.yml
```

### 5. Deploy the Application

```bash
ansible-playbook -i ansible/inventory.ini ansible/playbooks/deploy.yml --ask-vault-pass
```

Review the playbook variables, repository settings, and environment configuration before running these commands in a new environment.

## Verification

The following checks were performed during the deployment:

- The React frontend loaded through the public EC2 IP.
- The Node.js backend ran as a systemd service.
- The backend connected successfully to MongoDB.
- MongoDB authentication was tested successfully.
- CORS was configured to allow requests from the deployed frontend.
- A sample travel experience named **Incredible India** was submitted and displayed on the homepage.

Useful service checks:

```bash
sudo systemctl status nginx
sudo systemctl status travelmemory-backend
sudo journalctl -u travelmemory-backend -n 50 --no-pager
```

Run the MongoDB service check on the database server:

```bash
sudo systemctl status mongod
```

## Security Considerations

- Keep MongoDB port `27017` private; never expose it to the public internet.
- Store credentials in Ansible Vault or a secrets manager.
- Never commit `.env` files, AWS credentials, private SSH keys, or Terraform state files.
- Restrict SSH access to trusted source IPs.
- Use HTTPS with a domain name and TLS certificate for production.
- Review AWS resources and costs regularly.

## Future Improvements

- Configure a domain name and HTTPS.
- Add automated deployment through a CI/CD pipeline.
- Improve monitoring, logging, and backups.
- Use managed database services where appropriate.
- Add automated infrastructure and application tests.

## Author

**Gaury**

GitHub: https://github.com/gauryd

## Disclaimer

This project was developed for learning and deployment practice. Review the infrastructure, access policies, and application configuration before using it in production.
