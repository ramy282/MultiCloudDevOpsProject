def call(dockerfileapp) {
    stage('Build') {
        sh """
        docker build -t ${dockerfileapp} .
        """
    }

    stage('Unit Test') {
        sh """
        docker run ${dockerfileapp} python -m unittest discover -s tests
        """
    }
}
