# Configuration Management with Ansible:
 
## EC2 Configurations
This Ansible Roles configure the created EC2 instance by Terraform by installing Git , Docker , Java , Jenkins , SonarQube and Openshift CLI on an EC2 Instance.

## Challenges you may face:

1- If you can'y access the SonarQube even you open port 9000 on Secuirty Group
Solution:
  - Try to Run SonarQube inside a container
  - Run Command `sudo sysctl -w vm.max_map_count=262144` inside EC2 instane
  - use t3.large for EC2 instanse

## Ansible's Role structure

```
.
├── ansible.cfg
├── inventory
├── site.yml
└── roles
    ├── docker
    │   └── tasks
    │       └── main.yml
    ├── git
    │   └── tasks
    │       └── main.yml
    ├── jenkins
    │   └── tasks
    │       └── main.yml
    ├── openshift
    │   └── tasks
    │       └── main.yml
    └── sonarqube
        └── tasks
            └── main.yml

```

## Ansbile Role description
1- **Docker Role**
  - Install and Configure Docker Packages on EC2 instance
  - the main function in this Role
```
```
```  
