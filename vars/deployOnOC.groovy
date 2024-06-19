#!/usr/bin/env groovy
def call(String OpenShiftCredentialsID, String openshiftClusterurl, String openshiftProject, String imageName, String BUILD_NUMBER) {
    
    // login to OpenShift Cluster via cluster url & service account token
    withCredentials([string(credentialsId: "${OpenShiftCredentialsID}", variable: 'OpenShift_CREDENTIALS')]) {
            sh "oc login --server=${openshiftClusterurl} --token=${OpenShift_CREDENTIALS} --insecure-skip-tls-verify"
            sh "oc apply -f Deployment.yml"
            sh "oc apply -f service.yml"
            sh "oc expose svc grad-project-service"
    }

}
