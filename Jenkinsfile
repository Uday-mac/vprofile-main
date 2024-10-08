pipeline {
    agent any 
    tools {
      jdk "java11"
      maven "MAVEN3"
    }
    environment {
        sonar_scanner = 'sonar4.7'
        sonar_server = 'sonar'
        docker_cred = 'dockerhub'
        registry = 'udaymac/vproappdock'
    }
    stages {
        stage('cloing the code') {
            steps{
                git branch:'kube-cicd', url:'https://github.com/Uday-mac/vprofile-main.git'
            }
        }

        stage('build code') {
            steps {
                sh 'mvn install -DskipTests'
            }
            post {
                success {
                    echo "Now archieving.."
                    archiveArtifacts artifacts:'**target/*.war'
                }
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
                scanner_home = tool "${sonar_scanner}"
            }
            steps {
                withSonarQubeEnv("${sonar_server}") {
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

        stage('QualityGate') {
            steps{
                timeout(time: 1, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true
              }
            }
        }

        stage('build-docker-image') {
            steps {
                script {
                  dockerImage = docker.build (registry + ":V${{env.BUILD_NUMBER}}", ".")
                }
            }
        }

        stage('pushing image') {
            steps {
                script {
                    docker.withRegistry('',docker_cred) {
                        dockerImage.push("V${BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}