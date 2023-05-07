pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                echo 'pulling from SCM'
            }
        }
        stage('build') {
            steps {
                echo 'building the project'
            }
        }
        stage('deploy') {
            steps {
                echo 'deploying to stage environment'
            }
        }
    }
}