pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // this git repo
                checkout scm
         }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform fmt') {
            steps {
                sh 'terraform fmt'
            }
        }
        stage('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform destroy --auto-approve'
            }
        }

    }
}
