#!/usr/bin/env groovy

def call() {
    echo "Running SonarQube Analysis..."

    // Define your SonarQube server configuration credentials ID
    def sonarqubeCredentialsId = 'sonar-token'

    // Define other properties for SonarQube analysis
    def projectName = 'Grad-project'
    def projectKey = 'Grad-project'

    // Run withSonarQubeEnv to inject SonarQube environment variables
    withSonarQubeEnv(credentialsId: sonarqubeCredentialsId) {
        // Assuming you have a SonarQube tool installation named 'SonarQubeScanner'
        def scannerHome = tool name: 'sonar-scanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        
        sh """
        ${scannerHome}/bin/sonar-scanner \
          -Dsonar.projectName=${projectName} \
          -Dsonar.projectKey=${projectKey} \
          -Dsonar.java.binaries=.
        """
    }
}
