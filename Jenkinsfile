pipeline {
    agent any
    tools {
        terraform 'terraform144'
    }
    stages {
        stage('GIT Checkout') {
            steps {
                echo 'GIT Checkout'
            }
        }

        stage('Infra') {
            steps {
                echo 'Creating infra'
            }
        }

    }
}