def call(dockerHubCredentialsID, imageName) {
    stage('Build and Push Docker Image') {
        def commitHash = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        def fullImageName = "${imageName}:${commitHash}"

        sh """
        docker build -t ${fullImageName} .
        """

        docker.withRegistry('https://index.docker.io/v1/', dockerHubCredentialsID) {
            sh """
            docker push ${fullImageName}
            """
        }

        env.IMAGE_NAME = fullImageName
    }
}
