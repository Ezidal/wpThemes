
pipeline {
    agent {
        label 'ssh_agent'
    }
    stages {
        stage('Prepare Remote Environment') {
            steps {
                sshagent(credentials : ['vanya_777']) {
                    sh 'ssh -o StrictHostKeyChecking=no jenkins@192.168.4.92 cd wpthemes'
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
