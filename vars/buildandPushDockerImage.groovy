#!usr/bin/env groovy
def call(String dockerHubCredentialsID, imageName, BUILD_NUMBER) {

    // Build Docker image
    echo "Building Docker image..."
    sh "docker build -t ${imageName}:${BUILD_NUMBER} ."

    // Tag Docker image with latest
    sh "docker tag ${imageName}:${BUILD_NUMBER} ${imageName}:latest"

    // Log in to DockerHub 
    withCredentials([usernamePassword(credentialsId: "${dockerHubCredentialsID}", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
        sh "docker login -u ${USERNAME} -p ${PASSWORD}"
    }

    // Push Docker image with build number
    echo "Pushing Docker image with build number..."
    sh "docker push ${imageName}:${BUILD_NUMBER}"
    
    // Push Docker image with latest tag
    echo "Pushing Docker image with latest tag..."
    sh "docker push ${imageName}:latest"
}
