def call(openshiftCredentialsID, nameSpace, clusterUrl) {
    stage('Deploy on OpenShift Cluster') {
        withCredentials([kubeconfigFile(credentialsId: openshiftCredentialsID, variable: 'KUBECONFIG')]) {
            sh """
            oc login ${clusterUrl}
            oc project ${nameSpace}
            oc apply -f k8s/deployment.yaml
            oc rollout status deployment/${imageName}
            """
        }
    }
}
