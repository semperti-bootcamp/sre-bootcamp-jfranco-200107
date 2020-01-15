pipeline {
    agent {
        node (){
            label 'bc-jfranco'
        }
    }
    environment {
		VERSION = "1.1"
    }
    stages {
			stage('Docker Image Download & Run') {
				steps {
                	sh 'ansible-playbook docker-cd.yml --extra-vars "version=${VERSION}"'
				}
			}
			stage('Esperando respuesta del contenedor') {
				steps {
 
					timeout(300) {
						waitUntil {
						script {
						def r = sh script: 'curl http://localhost:8080', returnStatus: true
						return (r == 0);
						}
						}
					}
				}
			}
			stage('Prueba de acceso a la aplicación mediante un curl') {
				steps {
               		sh "curl http://localhost:8080"
				}
			}
    }
}