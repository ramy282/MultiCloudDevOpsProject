def call() {
    stage('Run Unit Test') {
        sh 'mvn test'
    }
}
