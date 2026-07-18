pipeline {

    agent {
        label 'dynamic-agent'
    }

    environment {

        AWS_DEFAULT_REGION = 'eu-north-1'
        TF_IN_AUTOMATION = 'true'

    }

    options {

        timestamps()

        ansiColor('xterm')

    }

    stages {

        stage('Checkout Source') {

            steps {

                echo "========== CHECKOUT SOURCE =========="

                checkout scm

            }

        }

        stage('Verify Tools') {

            steps {

                sh '''
                echo "========== VERIFY TOOL VERSIONS =========="

                echo ""

                echo "Terraform Version:"
                terraform version

                echo ""

                echo "AWS CLI Version:"
                aws --version

                echo ""

                echo "Git Version:"
                git --version

                echo ""

                echo "Java Version:"
                java -version

                echo ""

                echo "Current Directory:"
                pwd

                echo ""

                echo "Project Files:"
                ls -la
                '''

            }

        }

        stage('Terraform Init') {

            steps {

                echo "========== TERRAFORM INIT =========="

                sh '''
                terraform init
                '''

            }

        }

        stage('Terraform Validate') {

            steps {

                echo "========== TERRAFORM VALIDATE =========="

                sh '''
                terraform validate
                '''

            }

        }

        stage('Terraform Plan') {

            steps {

                echo "========== TERRAFORM PLAN =========="

                sh '''
                terraform plan -out=tfplan
                '''

            }

        }

        stage('Terraform Apply') {

            steps {

                echo "========== TERRAFORM APPLY =========="

                sh '''
                terraform apply -auto-approve tfplan
                '''

            }

        }

        stage('Terraform Outputs') {

            steps {

                echo "========== TERRAFORM OUTPUT =========="

                sh '''
                terraform output
                '''

            }

        }

        stage('Upload Project To S3') {

            steps {

                echo "========== UPLOADING PROJECT TO S3 =========="

                sh '''
                aws s3 cp . s3://jenkins-backup-vansh-2026/terraform-project/ \
                --recursive \
                --exclude ".git/*" \
                --exclude ".terraform/*"
                '''

            }

        }

    }

    post {

        always {

            echo "======================================"

            echo "Pipeline Finished"

            echo "======================================"

        }

        success {

            echo "Infrastructure Provisioned Successfully"

            echo "Project Uploaded To S3"

            echo "Dynamic Agent Will Be Automatically Terminated By Jenkins EC2 Plugin"

        }

        failure {

            echo "Pipeline Failed"

        }

    }

}