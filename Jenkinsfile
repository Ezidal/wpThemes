
pipeline {
    agent {
        label 'ssh_agent'
    }
    stages {
        stage('Переразворот вордпресс') {
            steps {
                sshagent(credentials : ['connect_server']) {
                    sh 'ssh -o StrictHostKeyChecking=no ${USER}@${HOST} "cd wpthemes; make down; git pull ;make up"'
                    sh 'echo "$gitlabUserName $gitlabUserUsername $gitlabUserEmail"'
                }
            }
        }    
    }
    post {
        always {
            mail to: "sergeyefimov9593@gmail.com",
                 subject: "Автоматическое оповещение о запуске wordpress после изменений",
                 body: "ну все, вордресс запускается уже в $BUILD_ID раз и очень даже неплохо"
        }
        failure {
            mail to: "sergeyefimov9593@gmail.com",
                 subject: "Автоматическое оповещение о плохом запуске wordpress после изменений",
                 body: "ну все, вордресс запускается уже в $BUILD_ID раз и в этот раз плохо"
        }
    }
}
