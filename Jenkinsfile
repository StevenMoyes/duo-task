pipeline {
    agent any
    stages {
        stage('Init') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        kubectl create ns prod || echo "------- Prod Namespace Already Exists -------"
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        kubectl create ns dev || echo "------- Prod Namespace Already Exists -------"
                        '''
                    } else {
                        sh'echo "Unrecognised branch"'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        docker build -t stevenmoyes/duo-jenk:latest -t stevenmoyes/duo-jenk:v${BUILD_NUMBER} .
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        docker build -t stevenmoyes/duo-jenk:latest -t stevenmoyes/duo-jenk:v${BUILD_NUMBER} .
                        '''
                    } else {
                        sh'echo "Unrecognised branch"'
                    }
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        docker push stevenmoyes/duo-jenk:latest
                        docker push stevenmoyes/duo-jenk:v${BUILD_NUMBER}
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        docker push stevenmoyes/duo-jenk:latest
                        docker push stevenmoyes/duo-jenk:v${BUILD_NUMBER}
                        '''
                    } else {
                        sh'echo "Unrecognised branch"'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh'''
                        kubectl apply -f . -n prod
                        kubectl set image deployment/flask-deployment flask-app=stevenmoyes/duo-jenk:v${BUILD_NUMBER} -n prod
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh'''
                        kubectl apply -f . -n dev
                        kubectl set image deployment/flask-deployment flask-app=stevenmoyes/duo-jenk:v${BUILD_NUMBER} -n dev
                        '''
                    } else {
                        sh'echo "Unrecognised branch"'
                    }
                }
            }
        }
    }
}