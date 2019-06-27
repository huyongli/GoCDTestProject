//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label  'android'}

    stages {
        stage('Build') {
            steps {
                script{
                    echo '-----build start-----'
                    sh "./gradlew assembleDebug -PbuildNo=${env.BUILD_NUMBER}"
                    echo '-----build finish-----'
                }
            }
        }
    }

    post {
        always {
            echo ' ----post always----'
            archiveArtifacts artifacts: '**/mapping.txt', onlyIfSuccessful: true
        }
    }
}