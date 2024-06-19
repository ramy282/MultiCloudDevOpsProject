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

1- **Colne the Repository**:
```
git clone https://github.com/ramy282/MultiCloudDevOpsProject.git
```

2- Create IAM User with the required acess 
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

![d4798434-5ab5-4201-951c-6ee37a36aa42](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/bb53aa1a-5eb5-4bd5-8143-fcad09b57b94)

6. **Run Ansible Playbook**
    see [Ansbile Roles and its description](https://github.com/ramy282/MultiCloudDevOpsProject/tree/dev/Ansible)

   - To Run the Playbook
     ```
     ansible-playbook -i inventory site.yml
     ```
     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/8ddb1bae-7b6c-4c9b-bf52-82314aa26a52)

     ![9ddd0437-a3d8-48cc-8d98-bb4849f02ff1](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/471195a0-ea0e-4d6e-b2b0-0d590e3d3ec2)

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/44f7bf17-5396-4df9-84c1-0fc0f594b52a)

      
 7. **Perpare Token for Jenkins**

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
    oc policy add-role-to-user admin system:serviceaccount:ramyanwar:token   
    ```
     
      ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/481ba74b-5c4b-497d-b5c2-ed734ff18fdc)

8. **Access SonarQube**
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

9. **Access Jenkins**
   - Access through http://EC2_IPv4:8080
   - login by initial admin password

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/78cf978a-b6b3-49c8-814f-4c7cef42538a)
    
   - **Install suggest plugins**

       ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/b21badb8-3221-45ca-8064-7049da568c67)
  
   - **Install SonarQube Scannar plugin**
   - go manage jenkins >> plugins >> available plugins >> Search for "SonarQube Scannar"

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/3c88effb-577b-4875-8089-ce66bd0dc574)

   - **Add your credentials**
   - go manage jenkins >> credentials >> system >> Add credentials
   - add github , DockerHub , oc-tocken and sonar-token

    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/c93ed9b3-aff3-401b-9844-ad399c7d3663)

    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/33e7d572-6f6a-48de-8047-8f3566cf2149)

   - **Add SonarQube Scanner in tools**:
   - go to manage jenkins >> tools >> scrool down to SconarQube installation >> Add SonarQube Scanner
  
    ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/13ba5e71-84b2-4c76-95c5-8bb82a542f4d)

   - **Add SonarQube Scanner in tools:**
   - go manage jenkins >> system >> scroll down to >> SonarQube Server >> Click add SonarQube
   - right chick on Enviroment variables
   - Enter name for SonarQube service and Enter SonarQube Token

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/87627423-8d44-4157-a023-9f82c8bfc1db)

   - **Add Shared Library:**
   - go manage jenkins >> system >> scroll down to >> Global Trusted pipline Libraries 
   - Enter shared library name and Default version
   - Choose Git and GitHub repository of shared library link
   - Choose GitHub credentials

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/58037662-660a-45a2-8302-cd3fee8fc52e)

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/7805060d-fb6b-43e8-a77d-6d2f98a48a38)

10- **Create a pipline:**
   - Choose New item >> Enter the name >> Choose pipline ok 

     ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/2b96d5ba-767e-4d27-b241-1a62619439a2)
    
   - Scroll under Pipline Choose 'pipline script from SCM'
   - Enter GitHub repository of shared library link
   - Choose GitHub credentials

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/0adacb1d-31b8-43cf-b9de-1e47aed51b4d)

   - Run the Pipline 
    
   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/676ed01f-09e8-492c-bb67-b55252fd1189)


   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/6bad417f-6aa9-43bc-9f1e-3b9a944ef571)


   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/4648558b-deae-4ec8-a6ee-df3498ffff06)


   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/95a96a0b-72d6-43d3-b15d-b749b2af5b9d)

 
   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/78de2664-ab9c-45fd-a2de-d12c13ca808e)


11- **Access the application**

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/76d5e6e3-dc7d-4548-b725-d7c2ed03d98b)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/be1ec537-183f-425e-9e5b-0fcf37f3cc2c)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/f3bb46f3-9005-4587-850b-d4c3f69992f6)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/517d6960-f4e2-4465-91f1-84d4978a2ca1)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/e4e3e6f8-e978-45e8-94a5-02992e01a1ca)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/70b88996-3694-48ea-9a11-e3ed4910f352)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/55f3c7f6-9779-47ed-b202-b95c8172154d)

   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/11dfa931-2dd9-43ec-a0d0-215ff1548f67)

          
