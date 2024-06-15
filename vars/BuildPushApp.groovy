def call(Dockerhub, DockerRegistry, DockerImage) {
    def COMMIT_HASH = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    def imageName = "${DockerRegistry}/${DockerImage}:${COMMIT_HASH}"

    stage('Build Docker Image') {
        sh """
        docker build -t ${imageName} .
        """
    }

    stage('Push Docker Image') {
        docker.withRegistry('https://index.docker.io/v1/', Dockerhub) {
            sh """
            docker push ${imageName}
            """
        }
    }

    return COMMIT_HASH
}
