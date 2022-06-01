pipeline {
  agent {label 'Dev'}
  tools {
      jdk 'jdk11'
      git 'Default'
      maven 'maven'
  }
    stages {
      stage ('gitclone') {
        steps {
          git branch: 'master', url: 'https://github.com/pallem260497/build.git'
        } 
      }
      stage ('listGit') {
        steps {
          sh 'ls -lr'
        } 
      }
      stage ('maven') {
        steps {
          sh 'mvn clean package'
        } 
      }
      stage ('listmaven') {
        steps {
          sh 'ls -lr'
        } 
      }
      stage ('maven path') {
        steps {
          sh 'pwd'
        } 
      }
      
      /*stage ('maven deploy') {
        steps {
          nexusArtifactUploader artifacts: [
              [
                  artifactId: 'webapp', 
                  file: 'target/webapp.war', 
                  type: 'war'
              ]
          ], 
          credentialsId: 'nexuss3',
          groupId: 'webapp',
          nexusUrl: '13.56.76.178:8081/repository/webapp-snapshot/',
          nexusVersion: 'nexus3',
          protocol: 'http',
          repository: 'webapp-snapshot',
          version: '1.0-SNAPSHOT'
        }
        
      }*/
      stage ('Docker image') {
        steps {
          sh 'sudo systemctl start docker'
          sh ' sudo docker build -t hemanth108/weapps:1.0.1 .'
        } 
      }
      stage ('docker crediential') {
        steps {
          withCredentials([string(credentialsId: 'docker-passwd', variable: 'dockerpasswd')]) {
           sh "sudo docker login -u hemanth108 -p ${dockerpasswd}"
           }
          sh 'sudo docker push hemanth108/weapps:1.0.1'
        } 
      }
      /*stage ('k8s') {
        steps {
          withCredentials([string(credentialsId: 'kubernatescommand', variable: 'kubernatespwd')]) {
          sh "pwd"
          sh "kubectl create -f ns.yaml"
          }
        } 
      }*/
      stage ('k8s crediential') {
        steps {  
            kubernetesDeploy configs: 'kubernatesfile.yaml', enableConfigSubstitution: false, kubeConfig: [path: ''], kubeconfigId: 'kubernates', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
      
      
        }          
      }
    }
}
