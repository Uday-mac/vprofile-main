pipeline {
    agent any 
    tools {
        jdk 'java11'
        maven 'MAVEN3'
    }
    stages {
        stage('clone_code') {
            steps {
                git clone branch: 'docker-ecs', url: 
            }
        }
    }
}