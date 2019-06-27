//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label  'android'}

    stages {
        stage('Build User') {
          steps {
            wrap([$class: 'BuildUser']) {
              sh 'echo "${BUILD_USER}"'
              buildName "${BUILD_NUMBER}-${BUILD_USER}"
            }
          }
        }
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