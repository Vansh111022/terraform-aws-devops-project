pipeline {

    agent {
        label 'dynamic-agent'
    }

    environment {
        AWS_DEFAULT_REGION = 'eu-north-1'
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh '''
                    echo "===== Tool Versions ====="

                    terraform version
                    aws --version
                    git --version
                    java -version

                    pwd
                    ls -la
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

    }

    post {

        always {
            echo "Pipeline Finished"
        }

        success {
            echo "Terraform Validation Successful"
        }

        failure {
            echo "Pipeline Failed"
        }

    }
}