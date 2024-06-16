def call() {
    stage('SonarQube Analysis') {
        withSonarQubeEnv('SonarQubeServer') {
            sh """
            sonar-scanner \
            -Dsonar.projectKey=${env.SonarProjectKey} \
            -Dsonar.sources=. \
            -Dsonar.host.url=${env.sonarqubeUrl} \
            -Dsonar.login=${env.sonarTokenCredentialsID}
            """
        }
    }
}
