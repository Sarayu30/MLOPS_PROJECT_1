pipeline {
    agent any
    environment {
        VENV_DIR = 'venv'  // Fixed typo ('very' → 'venv')
    }

    stages {
        stage('Cloning Github repo to Jenkins') {
            steps {
                script {
                    echo 'Cloning Github repo to Jenkins......'
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

        stage('Setting up Virtual Environment and Installing dependencies') {
            steps {
                script {
                    echo 'Setting up Virtual Environment and Installing dependencies...'
                    sh '''
                        python -m venv ${VENV_DIR}
                        . ${VENV_DIR}/bin/activate
                        pip install --upgrade pip
                        pip install -e .
                    '''
                }
            }
        }
    }
}