pipeline {
    agent any

    environment {
        APP_NAME = "saip-app"
        CONTAINER_NAME = "saip-container"
        LOG_DIR = "/opt/saip/logs"
    }

    triggers {
        pollSCM('H/5 * * * *') // Or webhook-based setup for efficiency
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Kpranay3151/TestDeploy.git', branch: 'main'
            }
        }

        stage('Check for WAR Updates') {
            when {
                changeset "**/deployments/*.war"
            }
            steps {
                echo "WAR file has been updated. Proceeding with build and deployment."
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${APP_NAME} ."
                }
            }
        }

        stage('Stop & Remove Existing Container') {
            steps {
                script {
                    sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    """
                }
            }
        }

        stage('Run New Container') {
            steps {
                script {
                    sh """
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        -p 4050:4040 \
                        -v ${LOG_DIR}:/usr/local/tomcat/logs \
                        ${APP_NAME}
                    """
                }
            }
        }
    }

    post {
        failure {
            echo 'Deployment failed!'
        }
        success {
            echo 'Deployment completed successfully!'
        }
    }
}
