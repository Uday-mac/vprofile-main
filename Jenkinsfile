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
   }
}