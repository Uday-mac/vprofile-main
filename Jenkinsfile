pipeline{
    agent any
    tools {
        jdk 'java11'
        maven 'MAVEN3'
    }
    environment {
        registry_credentials = 'ecr:us-east-1:aws_creds'
        appurl = "https://654654443485.dkr.ecr.us-east-1.amazonaws.com"
        imageurl = "654654443485.dkr.ecr.us-east-1.amazonaws.com/vprofileapp"
    }
    stages {
        stage('Cloning the code') {
            steps {
                git branch: 'docker-ecr', url: 'https://github.com/Uday-mac/vprofile-main.git'
            }
        }

        stage('Unit_test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Checkstyle_analysis') {
            steps {
                sh "mvn checkstyle:checkstyle"
            }
            post {
                success {
                    echo "Generated Analysis results"
                }
            }
        }

        stage('SonarCode_Analysis') {
            environment {
                scanner_home= tool 'sonar4.7'
            }
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' 
                       ${scanner_home}/bin/sonar-scanner \
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

        stage('QualityGate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
                
            }
        }

        stage('Docker_build') {
            steps {
                script {
                    dockerImage = docker.build( imageurl + ":${BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Upload to ecr') {
            steps {
                script {
                    docker.withRegistry(appurl, registry_credentials) {
                        dockerImage.push("${BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                    
                }
            }
        }
    }
}