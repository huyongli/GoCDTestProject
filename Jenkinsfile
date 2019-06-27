//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label  'android'}

    stages {
        stage('Build') {
            steps {
                script{
                    echo '-----build start-----'
                    sh './gradlew assembleDebug -PbuildNo=${env.BUILD_NUMBER}'
                    echo '-----build finish-----'
                }
            }
        }

        stage('mapping') {
            steps {
                script {
                    dir=$WORKSPACE
                    mappingDir='${env.$JOB_NAME}-mapping'
                    cd ..
                    cp "$dir"/app/build/outputs/mapping/debug/mapping.txt ./"$mappingDir"/"$BUILD_NUMBER"-mappging.txt
                }
            }
        }
    }

    post {
        always {
            echo ' ----post always----'
        }
    }
}