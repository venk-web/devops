pipeline {
    agent any
    stages {
        stage("Code Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/venk-web/devops'
            }
        }
        stage("Build Docker Image") {
            steps {
                sh 'docker build -t vensan965/devops:latest .'
            }
        }
        stage("Push Docker Image to Registry") {
            steps {
                sh '''
                echo "Vensan@2024" | docker login -u vensan965 --password-stdin
                docker push vensan965/devops:latest
                '''
            }
        }
        stage("Deploy to Kubernetes") {
            steps {
			    sh 'kubectl create deployment mydeploy --image=vensan965/devops:latest --replicas=2'
            }
        }
        stage('Expose service') {
            steps {
                sh 'kubectl expose deployment mydeploy --name=mysvc --port=90 --target-port=5000 --type=NodePort'
            }
        }
    }
}
