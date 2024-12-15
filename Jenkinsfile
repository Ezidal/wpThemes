
pipeline {
    agent {
        label 'ssh_agent'
    }
    stages {
        stage('Prepare Remote Environment') {
            steps {
                sshagent(credentials : ['vanya_777']) {
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@192.168.0.105 "cd wpthemes; git pull ;make up"'
                }
            }
        }    
    }

}
