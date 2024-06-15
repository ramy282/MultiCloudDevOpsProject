def call(Token_Sonar, SonarProjectKey, SonarHostUrl) {
    withSonarQubeEnv('SonarQubeServer') {
        sh """
        sonar-scanner \
        -Dsonar.projectKey=${SonarProjectKey} \
        -Dsonar.sources=. \
        -Dsonar.host.url=${SonarHostUrl} \
        -Dsonar.login=${Token_Sonar}
        """
    }
}
