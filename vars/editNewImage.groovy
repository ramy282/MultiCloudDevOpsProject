def call(githubToken, imageName, gitUserEmail, gitUserName, gitRepoName) {
    stage('Edit new image in deployment.yaml file') {
        sh """
        sed -i 's|image: .*|image: ${imageName}|g' k8s/deployment.yaml
        git config --global user.email "${gitUserEmail}"
        git config --global user.name "${gitUserName}"
        git add k8s/deployment.yaml
        git commit -m "Update image to ${imageName}"
        git push https://${gitUserName}:${githubToken}@github.com/${gitUserName}/${gitRepoName}.git HEAD:main
        """
    }
}
