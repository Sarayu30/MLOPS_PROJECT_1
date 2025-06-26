pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
    }

    stages {
        stage('Cloning GitHub repo to Jenkins') {
            steps {
                script {
                    echo 'Cloning GitHub repo to Jenkins...'
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
        }

        stage('Setting up virtual environment and installing dependencies') {
            steps {
                script {
                    echo 'Setting up virtual environment and installing dependencies...'
                }
                sh '''
                    python -m venv ${VENV_DIR}
                    source ${VENV_DIR}/bin/activate
                    pip install --upgrade pip
                    pip install -e .
                '''
            }
        }

        stage('Run Training Pipeline') {
            steps {
                script {
                    echo 'Running training pipeline...'
                }
                sh '''
                    source ${VENV_DIR}/bin/activate
                    python pipeline/training_pipeline.py
                '''
            }
        }

        stage('Start Application') {
            steps {
                script {
                    echo 'Starting application...'
                }
                sh '''
                    source ${VENV_DIR}/bin/activate
                    python application.py
                '''
            }
        }
    }
}
