pipeline {

    agent {
        docker {
            image 'jeet1418/vprofile-agent:latest'
            args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
            reuseNode true
        }
    }


    environment {
        IMAGE_NAME = "jeet1418/vproapp"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_CREDS = "dockerhub-creds"
    }

    stages {

        stage('Build Application') {
            steps {
                echo "Building Maven project..."

                sh '''
                    mvn clean package -DskipTests
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker Image..."

                sh '''
                    docker build \
                    -f Docker-files/app/Dockerfile \
                    -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {

                script {

                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDS) {

                        sh '''
                            docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        '''
                    }

                }

            }
        }

        stage('Update Helm Chart') {
            steps {
                sh '''
                yq -i '.app.image.tag = env(IMAGE_TAG)' helm/vprofile-charts/values.yaml
                '''

                sh 'cat helm/vprofile-charts/values.yaml'


            }
        }

        stage('Commit Changes') {
            steps {

                sh '''
                    git config --global --add safe.directory "$WORKSPACE"
                    git config user.name "Jenkins CI"
                    git config user.email "satyajit.1418@gmail.com"

                    git add helm/vprofile-charts/values.yaml

                    git commit -m "Update image tag to ${IMAGE_TAG}" || true

                    git push origin HEAD:main
                '''


            }
        }

    }

}