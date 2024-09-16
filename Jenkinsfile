def COLOR_MAP = [
  'SUCCESS': 'good',
  'FAILURE': 'danger',

]

pipeline {
   agent any
   tools {
      maven "MAVEN3"
      jdk "java11"
   }
   environment {
    nexus_url = '54.87.164.65:8081'
    nexus_credentials_id = 'nexuslogin'
   }
   stages {
      stage('Cloning the code') {
        steps {
            git branch: 'jenkins', url: 'https://github.com/Uday-mac/vprofile-main.git'
        }
      }
      stage('Build code') {
        steps {
            sh 'mvn clean install -DskipTests'
        }
        post {
            success {
                echo "Archieving artifcats"
                archiveArtifacts artifacts: '**/*.war'
            }
        }
      }
      stage('UNIT TEST') {
        steps {
            sh 'mvn test'
        }
      }
      stage('Checktyle') {
        steps {
          sh 'mvn checkstyle:checkstyle'
        }
      }
      stage('Sonar_analysis'){
        environment {
          SCANNER_HOME = tool 'sonar4.7'
        }
        steps {
          withSonarQubeEnv('sonar') {
            sh '''
                 ${SCANNER_HOME}/bin/sonar-scanner \
                  -Dsonar.projectKey=vprofile \
                  -Dsonar.projectName=vprofile \
                  -Dsonar.projectVersion=1.0 \
                  -Dsonar.sources=src/ \
                  -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                  -Dsonar.junit.reportPaths=target/surefire-reports/ \
                  -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                  -Dsonar.checkstyle.reportPaths=target/checkstyle-results.xml 
            '''
          }
        }
      }
      stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        
      }
      stage('upload to nexus') {
        steps {
          script {
            nexusArtifactUploader(
                        nexusVersion: 'nexus3',
                        protocol: 'http',
                        nexusUrl: "${nexus_url}",
                        groupId: "QA",
                        version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
                        repository: 'vprofile-repo',
                        credentialsId: "${nexus_credentials_id}",
                        artifacts: [
                            [artifactId: "vproapp",
                             classifier: '',
                             file: "target/vprofile-v2.war",
                             type: "war"]
                        ]
              )
          }
        }
      }
   }
   post {
    always{
      echo "Slack notification"
      slackSend channel: '#jenkins',
      color: COLOR_MAP[currentBuild.currentResult],
      message: "*${currentBuild.currentResult}:* job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
    }
   }
}