pipeline {
   agent any
   tools {
      maven "MAVEN3"
      jdk "java11"
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
            sucess {
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
   }
}