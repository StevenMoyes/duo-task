pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t stevenmoyes/duo-jenk:latest -t stevenmoyes/duo-jenk:v${BUILD_NUMBER} .
                '''
            }
        }
        stage('Push') {
            steps {
                sh '''
                docker push stevenmoyes/duo-jenk:latest
                docker push stevenmoyes/duo-jenk:v${BUILD_NUMBER}   
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh'''
                kubectl apply -f .
                kubectl set image deployment/flask-deployment flask-app=stevenmoyes/duo-jenk:v${BUILD_NUMBER}
                '''
            }
        }
    }
}
