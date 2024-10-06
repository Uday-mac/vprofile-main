pipeline {
    agent any 
    tools {
      jdk java11
      maven MAVEN3
    }
    environment {
        sonar_scanner = 'sonar4.7'
        sonar_server = 'sonar'
    }
    stages {
        stage('cloing the code') {
            steps{
                git clone branch:'kube-cicd', url:'https://github.com/Uday-mac/vprofile-main.git'
            }
        }

        stage('unit test') {
            steps{
                sh 'mvn test'
            }
        }

        stage('checkstyle analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('sonarqube analysis') {
            environment {
                scanner_home = tool ${sonar_scanner}
            }
            steps {
                withSonarQubeEnv(${sonar_server}) {
                    sh '''${scanner_home}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=vprofile-repo \
                    -Dsonar.projectVersion=v1.0 \
                    -Dsonar.sources=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest \
                    -Dsonar.junit.reportsPath=target/surefire-reports/ \
                    -Dsonar.jacoco.repotysPath=target/jacoco.exec \
                    -Dsonar.java.checkstyle.reportsPath=target/checkstyle-results.xml 
                    '''
                }
            }
        }
    }
}