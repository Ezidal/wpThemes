
pipeline {
    agent {
        label 'ssh_agent'
    }
    stages {
        stage('Переразворот вордпресс') {
            steps {
                sshagent(credentials : ['connect_server']) {
                    sh 'ssh -o StrictHostKeyChecking=no ${USER}@${HOST} "cd wpthemes; make down; git pull ;make up"'
                }
            }
        }    
    }
}
