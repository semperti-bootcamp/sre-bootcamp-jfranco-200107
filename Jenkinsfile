// Provide list of environments [needs to have a folder within ansible/environments to check hosts]
list_of_environments = ['staging', 'production']
pipeline {

    // Define Agent and Stages
    agent {
        node() {
            label 'rc-sre-jonathan-tissot'
        }
    }



    stages {
        // Run only once to configure Jenkins Slave
        stage('Configure Jenkins Slave') {
            steps{
                sh "yum install wget unzip epel-release ansible awscli -y"
                sh "curl https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip -o /usr/local/bin/terraform.zip"
                sh "unzip -u /usr/local/bin/terraform.zip -d /usr/local/bin/"
                sh 'export ANSIBLE_HOST_KEY_CHECKING=False'
            }
        }
        
        // Function defined below using Credentials for Ansible
        stage('Configure Docker Image on Docker Host') {
            steps{
                withCredentials([file(credentialsId: 'ANSIBLE_JSON_ALL', variable: 'ANSIBLE_JSON')]) {
                    configure_docker(list_of_environments)
                }
            }   
        }

        // Function defined below to Check Health in a loop
        stage('Check Health Status on WebServers') {
            steps {
                check_health_status(list_of_environments)
            }
        }
        
    }

}
// Function to configure Docker on list provided above
def configure_docker(env) {
    for (int i = 0; i < env.size();i++) {
        sh "echo Configuring Docker for ${env[i]}"
        sh "ansible-playbook --extra-vars @$ANSIBLE_JSON ansible/docker-configure.yml -i ansible/environments/${env[i]}"          
        sh "ansible-playbook --extra-vars @$ANSIBLE_JSON ansible/deploy-java-docker.yml -i ansible/environments/${env[i]}"
        sh "echo Webserver configured at port 8080 in `eval cat ansible/environments/${env[i]}/${env[i]}.inv | grep 10`"
    }
}

// Function to check health on each web
def check_health_status(env) {
    for (int i = 0; i < env.size();i++) {
        sh "echo Checking health for ${env[i]}"
        sh "sleep 10s"
        sh "curl -m 60 http://`eval cat ansible/environments/${env[i]}/${env[i]}.inv | grep 10`:8080"
    }
}