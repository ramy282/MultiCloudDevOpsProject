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
1. **Docker Role**
   - Install and Configure Docker Packages on EC2 instance
   - The main functions in this Role
```
- name: Install dependencies
  apt:
    name:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
  state: present
```

```
- name: Install Docker Package
  apt:
    name: docker-ce
    state: latest
```

```
- name: Check Docker service is started and enabled
  systemd:
    name: docker
    state: started
    enabled: yes
```

2. **Git**
   - Install Git Package on EC2
   - The main function in this Role

```
- name: Install Git package 
  apt:
    name: git
    state: latest
    update_cache: yes
    become: true
```

3. **Jenkins**
   - Install Jenkins service and configure plugin management
   - The main functions in this Role

```
- name: Pull Jenkins image from DockerHub
  docker_image:
    name: jenkins/jenkins
    tag: lts
    source: pull
```

```
- name: Start Jenkins container inside EC2 
  command: sudo docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -d -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --cpus=2 --memory=2g --memory-swap=2g jenkins/jenkins:lts
```

```
- name: Install Java inside Jenkins container
  retries: 5
  delay: 10
  command: docker exec -u 0 jenkins bash -c "apt-get update && apt-get install -y wget && wget -O /tmp/openjdk-17_linux-x64_bin.tar.gz https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz && mkdir -p /opt/java/openjdk && tar -zxvf /tmp/openjdk-17_linux-x64_bin.tar.gz -C /opt/java/openjdk --strip-components=1 && update-alternatives --install /usr/bin/java java /opt/java/openjdk/bin/java 1 && update-alternatives --set java /opt/java/openjdk/bin/java"
  register: java_install
  until: java_install.rc == 0
```

4. **openshift**
   - Install OpenShift CLI to manage Openshift Cluster
   - The main functions in this Role

```
 name: Download oc CLI on EC2
 get_url:
   url: https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz
   dest: /tmp/openshift-client-linux.tar.gz
   mode: '0644'
```

5. **SonarQube**
   - Install PostgresSQL Database and Install SonarQube tool that continuously inspects code quality and security.
   - The main functions in this Role

```
- name: Run PostgreSQL container inside EC2
  docker_container:
    name: sonarqube_db
    image: postgres:13
    state: started
    restart_policy: always
    env:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
      POSTGRES_DB: sonarqube
    volumes:
      - postgresql:/var/lib/postgresql/data
    cpus: 1
    memory: 2g
```

```
- name: Run SonarQube container inside EC2
  docker_container:
    name: sonarqube
    image: sonarqube:latest
    state: started
    restart_policy: always
    env:
      SONAR_JDBC_URL: jdbc:postgresql://sonarqube_db:5432/sonarqube
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    ports:
      - "9000:9000"
    volumes:
      - sonarqube_conf:/opt/sonarqube/conf
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_extensions:/opt/sonarqube/extensions
    links:
      - sonarqube_db
    cpus: 2
    memory: 4g
```

## Run The PlayBook 

- Create the [playbook](https://github.com/ramy282/MultiCloudDevOpsProject/blob/dev/Ansible/site.yml) and mention the roles by their sequance
- Put the IPv4 public address in the [inventory](https://github.com/ramy282/MultiCloudDevOpsProject/blob/dev/Ansible/inventory) file
- Put the Configuration of your EC2 in [ansbile.cfg ](https://github.com/ramy282/MultiCloudDevOpsProject/blob/dev/Ansible/ansible.cfg) file

- Run the playbook
```
ansible-playbook -i inventory site.yml
```
