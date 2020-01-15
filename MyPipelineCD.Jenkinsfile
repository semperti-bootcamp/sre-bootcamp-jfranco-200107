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
			stage('Stage 1 - Docker: Estopeando instancias previas') {
				steps {
                	sh 'ansible-playbook docker-clean.yml'
				}
			}
			stage('Stage 2 - Docker Image Download') {
				steps {
                	sh 'ansible-playbook docker-download.yml --extra-vars "version=${VERSION}"'
				}
			}
			stage('Stage 3 - Docker Run') {
				steps {
                	sh 'ansible-playbook docker-run.yml --extra-vars "version=${VERSION}"'
				}
			}
			stage('Stage 4 - Esperando respuesta del contenedor') {
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
			stage('Stage 5 - Prueba de acceso a la aplicación mediante un curl') {
				steps {
               		sh "curl http://localhost:8080"
				}
			}
    }
}