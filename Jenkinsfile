pipeline {
  environment {
    registry = "paranerd/jenkins-test"
    registryCredential = 'dockerHub'
    dockerImage = ''
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
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Clean up') {
      steps {
        sh 'docker rmi $registry:$BUILD_NUMBER'
      }
    }
  }
}
