//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label  'android'}

    parameters {
        string(name: 'buildType', defaultValue: getBuildType(env.JOB_NAME), description: 'is the apk build type')
        string(name: 'buildEnv', defaultValue: getBuildEnv(env.JOB_NAME), description: 'is the apk build env')
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
                    sh """
                        gitRevision=`git rev-parse --short HEAD`
                        ./gradlew assemble${params.buildEnv}${params.buildType} -PbuildNo=${env.BUILD_NUMBER} -PgitRevision=gitRevision
                    """
                    echo '-----build finish-----'
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