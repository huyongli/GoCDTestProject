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
                        echo '✈ -------------------------------------------- ✈'
                        apkName="app-${params.buildEnv.toLowerCase()}-${params.buildType.toLowerCase()}-n${env.BUILD_NUMBER}.apk"
                        apkPath="./app/build/outputs/apk/${params.buildEnv.toLowerCase()}/${params.buildType.toLowerCase()}/${apkName}"
                        appId="com.laohu.gocdtestproject.${params.buildType.toLowerCase()}"
                        appName="GoCd ${params.buildType.toUpperCase()}"

                        echo '✈ -------------------------------------------- ✈'
                        echo 'Get fir credential...'
                        credential=\$(curl -X "POST" "http://api.fir.im/apps" \
                                    -H "Content-Type: application/json" \
                                    -d "{\"type\":\"android\", \"bundle_id\":\"${appId}\", \"api_token\":\"${env.FIR_API_TOKEN}\"}" \
                                    2>/dev/null)
                                    binary_response=\$(echo ${credential} | grep -o "binary[^}]*")
                                    KEY=\$(echo ${binary_response} | awk -F '"' '{print \$5}')
                                    TOKEN=\$(echo ${binary_response} | awk -F '"' '{print \$9}')
                                    UPLOAD_URL=\$(echo ${binary_response} | awk -F '"' '{print \$13}')

                        echo '✈ -------------------------------------------- ✈'
                        echo 'Uploading to fir...'
                        response=\$(curl -F "key=${KEY}" \
                        -F "token=${TOKEN}" \
                        -F "file=@${apkPath}" \
                        -F "x:build=${env.BUILD_DISPLAY_NAME}" \
                        -F "x:name=${appName}" \
                        ${UPLOAD_URL}
                        )
                        echo $response;
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