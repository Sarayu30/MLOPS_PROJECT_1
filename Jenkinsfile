pipeline {
    agent any
    environment {
        VENV_DIR = 'venv'
        GCP_PROJECT = "gcp1-463510"
        GCLOUD_PATH = "/var/jenkins_home/google-cloud-sdk/bin"
    }

    stages {
        // Stage 1: Clone Repo
        stage('Cloning Github repo to Jenkins') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'github-token',
                        url: 'https://github.com/Sarayu30/MLOPS_PROJECT_1.git'
                    ]]
                )
            }
        }

        // Stage 2: Setup Python
        stage('Setup Virtual Environment') {
            steps {
                sh """
                    python -m venv ${VENV_DIR}
                    . ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                """
            }
        }

        // Stage 3: Docker Build & Push (with error handling)
        stage('Build and Push Docker Image') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([file(credentialsId: 'gcp-key', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                            sh '''
                                export PATH=$PATH:${GCLOUD_PATH}
                                gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}
                                gcloud config set project ${GCP_PROJECT}
                                gcloud auth configure-docker --quiet
                                docker build -t gcr.io/${GCP_PROJECT}/ml-project:latest .
                                docker push gcr.io/${GCP_PROJECT}/ml-project:latest
                            '''
                        }
                    }
                }
            }
        }
    }
}