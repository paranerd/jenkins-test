pipeline {
  environment {
    registry = "paranerd/jenkins-test"
    registryCredential = 'dockerHub'
    dockerImage = ''
    tag = sh(returnStdout: true, script: 'git tag --contains').trim()
  }

  agent any

  stages {
    stage('Cloning git') {
      steps {
        git 'https://github.com/paranerd/jenkins-test.git'
      }
    }
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build registry
        }
      }
    }
    stage('Deploy Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push(":$tag")
            dockerImage.push("latest")
          }
        }
      }
    }
    stage('Clean up') {
      steps {
        sh 'docker rmi $registry:$tag'
      }
    }
  }
}
