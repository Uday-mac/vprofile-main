pipeline {
    agent any 
    tools {
        jdk 'java11'
        maven 'MAVEN3'
    }
    stages {
        stage('clone_code') {
            steps {
                git clone branch: 'docker-ecs', url: 'https://github.com/Uday-mac/vprofile-main.git'
            }
        }

        stage('Unit_test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Checkstyle_analysis') {
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
            post {
                success {
                    steps {
                        echo "generating checkstyle reports"
                    }
                }
            }
        }
    }
}