pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
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
                sh '''
                    terraform init
                    terraform apply --auto-approve
                '''
            }
        }

    }
}