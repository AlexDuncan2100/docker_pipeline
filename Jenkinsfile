pipeline {
    agent any

    environment {
        APP_NAME = 'mywebapp'
        VERSION = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${APP_NAME}:${VERSION} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Remove old container if it exists
                    sh "docker rm -f ${APP_NAME} || true"

                    // Run the new container
                    sh "docker run -d -p 80:80 --name ${APP_NAME} ${APP_NAME}:${VERSION}"
                }
            }
        }
    }

    post {
        always {
            // Always print this message after the pipeline completes
            echo 'Pipeline completed.'
        }
    }
}
