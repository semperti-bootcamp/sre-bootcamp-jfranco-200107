pipeline {
    agent {
        node (){
            label 'bc-jfranco'
        }
    }
//    environment {
		//VERSION = "99.99" Lo sacamos por un servicio de API que nos da la version
//    }

    stages {
			stage('Step 1 - Configuración') {
				steps {
					sh "sudo /opt/openvpn/connect-vpn.sh"
				}
			}
			stage('Step 2 - Unit testing') {
				steps {
					sh "echo TBD"
 					sh "mvn test -f Code/pom.xml"
				}
			}
			stage('Step 3 - Snapshot & Upload a Nexus') {
				when {
					not {
							branch 'task10-master'
						}
            	}
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/newsnapshot/journals').trim()
                }
				steps {
					sh 'echo Generamos un numero nuevo de snapshot, solo se actualiza el valor 1.1.X' 
					sh 'echo Version ${VERSIONAPI}' 
                	sh 'ansible-playbook snapshot.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			stage('Step 3 - Release & Upload a Nexus') {
				when {
                	// Only say hello if a "greeting" is requested
                	//expression { params.REQUESTED_ACTION == 'greeting' }
					branch 'task10-master'
            	}
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/newrelease/journals').trim()
                }
				steps {
					sh 'echo Generamos un numero nuevo de version ya que se trata de un release' 
					sh 'echo Version ${VERSIONAPI}' 
					sh 'ansible-playbook release.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			stage('Step 4 - Creacion del Docker & Publicacion ') {
				when {
					branch 'task10-master'
            	}
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/getlast/journals').trim()
                }
				steps {
					sh 'ansible-playbook docker-publish.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			stage('Stage 5 - Docker: Estopeando instancias previas') {
				when {
					branch 'task10-master'
            	}
				steps {
                	sh 'ansible-playbook docker-clean.yml'
				}
			}
			stage('Stage 6 - Docker Image Download') {
				when {
					branch 'task10-master'
            	}
				steps {
                	sh 'ansible-playbook docker-download.yml --extra-vars "version=${VERSION}"'
				}
			}
			stage('Stage 7 - Docker Run') {
				when {
					branch 'task10-master'
            	}
				steps {
                	sh 'ansible-playbook docker-run.yml --extra-vars "version=${VERSION}"'
				}
			}
			stage('Stage 8 - Esperando respuesta del contenedor') {
				when {
					branch 'task10-master'
            	}
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
			stage('Stage 9 - Prueba de acceso a la aplicación mediante un curl') {
				when {
					branch 'task10-master'
            	}
				steps {
               		sh "curl http://localhost:8080"
				}
			}
			 
    }
}