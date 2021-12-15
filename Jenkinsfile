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
    stage('Show tag') {
      steps {
        echo $tag
      }
    }
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$tag"
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
        sh 'docker rmi $registry:$tag'
      }
    }
  }
}
