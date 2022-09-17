pipeline {
    agent any 
    tools {
         maven 'maven'
         jdk 'java'
    }
    stages {
        stage('Stage-0 : Static Code Quality Using SonarQube') { 
            steps {
                sh 'mvn sonar:sonar' 
            }
        }
        stage('Stage-1 : Clean') { 
            steps {
                sh 'mvn clean'
            }
        }
        stage('Stage-2 : Validate') { 
            steps {
                sh 'mvn validate'
            }
        }
        stage('Stage-3 : Compile') { 
            steps {
                sh 'mvn compile'
            }
        }
        stage('Stage-4 : Test') { 
            steps {
                sh 'mvn test -DskipTests'
            }
        }
        stage('Stage-5 : Install') { 
            steps {
                sh 'mvn install -DskipTests'
            }
        }
        stage('Stage-6 : Verify') { 
            steps {
                sh 'mvn verify -DskipTests'
            }
        }
        stage('Stage-7 : Package') { 
            steps {
                sh 'mvn package -DskipTests'
            }
        }
        stage('Stage-8 : Deploy an Artifact to Artifactory Manager i.e. Nexus/Jfrog') { 
            steps {
                sh 'mvn deploy -DskipTests'
            }
        }
//         stage('Stage-9 : Deployment - Deploy a Artifact devops-2.0.0-SNAPSHOT.war file to Tomcat Server') { 
//             steps {
//                 sh 'curl -u admin:redhat@123 -T target/**.war "http://54.144.11.145:8080/manager/text/deploy?path=/stardevops&update=true"'
//             }
//         } 
//         stage('Stage-10 : SmokeTest') { 
//             steps {
//                 sh 'curl --retry-delay 10 --retry 5 "http://54.144.11.145:8080/stardevops"'
//             }
//         }
    }
}
