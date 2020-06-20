# Terraform Code Blocks

1. Provider
2. Resource
3. Provisioner
4. Variable
5. Output

# Terraform Commands

* $terraform version
* $terraform init
* $terraform plan
* $terraform apply
* $terraform show
* $terraform destroy


# Local Provisioner Scenario

1. Deploy AWS EC2 instance in default VPC
2. Create Security Group  and allow port 22, 80 & 8080
3. Install Jenkins in the created EC2 instance through the ansible playbook
4. Validate the Jenkins in the web browser
# http://<ec2.public.ip>:8080
