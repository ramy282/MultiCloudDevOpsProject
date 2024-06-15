def call(OpenShiftConfig, DockerRegistry, DockerImage, OpenShiftProject) {
    def COMMIT_HASH = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    def imageName = "${DockerRegistry}/${DockerImage}:${COMMIT_HASH}"

    stage('Deploy to OpenShift') {
        sh """
        oc --config=${OpenShiftConfig} project ${OpenShiftProject}
        oc --config=${OpenShiftConfig} set image dc/${DockerImage} ${DockerImage}=${imageName}
        oc --config=${OpenShiftConfig} rollout status dc/${DockerImage}
        """
    }

    return COMMIT_HASH
}
