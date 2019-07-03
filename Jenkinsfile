//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label  'android'}

    parameters {
        string(name: 'buildType', defaultValue: 'Debug', description: 'is the apk build type')
        string(name: 'buildEnv', defaultValue: 'Dev', description: 'is the apk build env')
    }

    stages {
        stage('BuildName') {
          steps {
            buildName "${BUILD_NUMBER}-${params.buildEnv}-${params.buildType}"
          }
        }
        stage('Build') {
            steps {
                script{
                    echo '-----build start-----'
                    sh "./gradlew assemble${params.buildEnv}${params.buildType} -PbuildNo=${env.BUILD_NUMBER}"
                    echo '-----build finish-----'
                }
            }
        }
        stage('publish') {
            steps {
                script {
                    sh """
                        sh ./publish.sh ${env.FIR_API_TOKEN} com.laohu.gocdtestproject.${params.buildType.toLowerCase()} ./app/build/outputs/apk/${params.buildEnv.toLowerCase()}/${params.buildType.toLowerCase()}/app-${params.buildEnv.toLowerCase()}-${params.buildType.toLowerCase()}-n${env.BUILD_NUMBER}.apk GoCd ${params.buildType.toUpperCase()} ${env.BUILD_DISPLAY_NAME}
                    """
                }
            }
        }
    }

    post {
        always {
            echo ' ----post always----'
            archiveArtifacts artifacts: '**/mapping.txt, **/*.apk', onlyIfSuccessful: true
        }
    }
}

def getBuildEnv(pipeLineName) {
    if(pipeLineName.toLowerCase().indexOf('dev') != -1) {
        return 'Dev'
    } else if(pipeLineName.toLowerCase().indexOf('qa') != -1) {
        return 'Qa'
    } else {
        return 'Prod'
    }
}

def getBuildType(pipeLineName) {
    if(pipeLineName.toLowerCase().indexOf('debug') != -1) {
        return 'Debug'
    } else {
        return 'Release'
    }
}