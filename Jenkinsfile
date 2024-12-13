pipeline {
    agent {
        label 'ubuntu'
    }
    stages {
        stage('Расшифровка envvvv') {
            steps {
                script {
                    sh 'make decrypt'
                }
            }
        }
        stage('Расчищаем платформу от старичков') {
            steps {
                script {
                    sh 'make down'
                }
            }
        }
        stage('Запускаем новых ребят') {
            steps {
                script {
                    sh 'make up'
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
