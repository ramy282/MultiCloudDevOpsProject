# MultiCloudDevOpsProject

## Project Overview 
The MultiCloudDevOpsProject aims to establish a robust and scalable infrastructure for continuous integration and continuous deployment (CI/CD) in a multi-cloud environment. The project leverages various DevOps tools and practices to automate the provisioning, configuration, containerization, integration, deployment, and monitoring of applications. This project serves as a comprehensive solution to streamline the development lifecycle, from code commit to deployment, ensuring high availability, scalability, and reliability.

![digram](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/267cb150-ab42-44d8-9be4-233afb210c4d)

## Objective:
1. Repository and Version Control:
   - Set up a structured GitHub repository with distinct branches for development and production to manage and track code changes efficiently.

2. Infrastructure Provisioning:
   - Utilize Terraform to automate the provisioning of AWS infrastructure components, including VPC, subnets, security groups, and EC2 instances.
   - Ensure modularization of Terraform scripts for reusability and maintainability.

3.Configuration Management:
  - Employ Ansible to automate the configuration of EC2 instances, ensuring the installation of required packages for application deployment, Jenkins, and SonarQube.
  - Utilize Ansible roles to promote code reuse and organization.

4.Containerization:
  - Create Dockerfiles to containerize the application, ensuring consistent and portable environments across different stages of development and deployment.

5. Continuous Integration:
   - Configure Jenkins to automate the building of Docker images upon code commits, integrating it into the CI/CD pipeline to ensure continuous testing and integration.

6. Automated Deployment Pipeline:
  - Develop a Jenkins pipeline (Jenkinsfile) to automate the deployment process, including stages for Git checkout, build, unit testing, SonarQube testing, and deployment on OpenShift.
  - Leverage a shared Jenkins library for common pipeline functionalities.

7. Monitoring and Logging:
   - Set up centralized logging on OpenShift to collect and manage container logs, facilitating better monitoring and troubleshooting.

8. AWS Integration:
   - Integrate AWS services, including using S3 for Terraform backend state management and CloudWatch for monitoring infrastructure and application performance.

## Used Technologies 
- **GitHub**: Contains a GitHub Actions workflow directory for configuring CI/CD processes.
  
- **Terraform**: Scripts for provisioning AWS infrastructure components such as VPCs, subnets, EC2 instances, S3 buckets, CloudWatch, and SNS.

- **Ansible**: Playbooks for automated configuration of EC2 instances with SonarQube, Jenkins, and OpenShift CLI.

- **Docker**: Dockerfiles for containerizing the Spring Boot application.

- **Jenkins**: Setup for a release pipeline to automate the build, test, push, and deployment stages.

- **PostgreSQL**: Provides a robust, scalable relational database to store application data securely and efficiently for the Spring Boot application.
  
- **SonarQube**: Maintains code quality and security standards for Spring Boot development.

- **OpenShift Cluster**: Kubernetes manifests for application deployment and centralized monitoring/logging on OpenShift.

## Quik Start 

1- Colne the Repository:
```
git clone https://github.com/ramy282/MultiCloudDevOpsProject.git
```

2- Create IAm User with the required acess 
![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/27ca029f-dc48-4127-9879-ab0fd098cbbc)

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/1b6f343e-7e78-4954-927f-717a46101855)

3- Login by aws credentials through command `aws configure`
  - Enter aws_access_key_id and aws_secret_access_key

4- Create key Pair for the EC2 Instance in your region and download it 

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/7e95ae9c-814f-4415-8c47-c99a8885029f)

5- Move to Terraform Directory 
  see [Terraform Modules and its description](https://github.com/ramy282/MultiCloudDevOpsProject/tree/dev/Terraform)
  
```
cd Terraform
terraform init
terraform plan
terraform apply
```
![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/c7fbc003-2481-4b79-a760-ef6ca5d82c08)

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/f08e3877-0e0e-427d-9df9-3c0f4783a1ee)

applyyyyyyyyyyyyyyyyyyyyyyyyyyyy

6. Run Ansible Playbook
    see [Ansbile Roles and its description](https://github.com/ramy282/MultiCloudDevOpsProject/tree/dev/Ansible)

   - To Run the Playbook
     ```
     ansible-playbook -i inventory site.yml
     ```
  sssssssssssssssssssssssssssssssssssssss

 7. Perpare Token for Jenkins

    - To get Githaub Token
    - go to settings >> Developer settings >> tokens (Classic) >> Gentrate new token

      ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/b9b377d1-c56d-4f43-aa68-9237cf578ab2)
   
    - To get DockerHub token
    - go to Account settings >> secuirty >> New access token

      ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/31fe735b-ded1-404a-a905-ab7d47000e5f)

    - To get oc token
    - login to your oc cluster
    - Create Service account
    - print the token 

    ```
     oc create serviceaccount token
     oc sa get-token token    
    
     
      ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/481ba74b-5c4b-497d-b5c2-ed734ff18fdc)

8. Access SonarQube
   - access through http://EC2_IPv4:9000
   - login by Username admin and password admin

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/372bdfb9-798a-4963-b02b-4dfb67c80ec0)

   - Create a local Project >> Enter your Project name >> use global settings

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/f0d208f7-7fbe-4f23-be0e-8a85c8a0a4d3)

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/c4617542-37d8-4502-89e1-8da1694508b2)

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/b3a4a9b1-8ecd-4587-9f6a-fec8a4b3db61)

   - to get SonarQube Access token:
   - Under Adminstration section click secuirty >> under token click create token
  
     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/e7123a10-ecf8-4db6-a6fd-e110f6cbf98a)
   
    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/a9c2f7f4-d619-4486-9a80-79a220c00495)

9. Access Jenkins
   - Access through http://EC2_IPv4:8080
   - login by initial admin password

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/78cf978a-b6b3-49c8-814f-4c7cef42538a)
    
   - Install suggest plugins

       ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/b21badb8-3221-45ca-8064-7049da568c67)
  
   - Install SonarQube Scannar plugin
   - go manage jenkins >> plugins >> available plugins >> Search for "SonarQube Scannar"

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/3c88effb-577b-4875-8089-ce66bd0dc574)

   - Add your credentials
   - go manage jenkins >> credentials >> system >> Add credentials
   - add github , DockerHub , oc-tocken and sonar-token

    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/c93ed9b3-aff3-401b-9844-ad399c7d3663)

    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/33e7d572-6f6a-48de-8047-8f3566cf2149)

   - Add SonarQube Scanner in tools:
   - go to manage jenkins >> tools >> scrool down to SconarQube installation >> Add SonarQube Scanner
  
    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/13ba5e71-84b2-4c76-95c5-8bb82a542f4d)

   - 
