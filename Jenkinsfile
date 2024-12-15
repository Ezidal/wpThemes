
pipeline {
    agent {
        label 'ssh_agent'
    }
    stages {
        stage('Prepare Remote Environment') {
            steps {
                sshagent(credentials : ['vanya_777']) {
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@${HOST} "cd wpthemes; make down; git pull ;make up"'
                }
            }
        }    
    }
}
