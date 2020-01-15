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
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/newsnapshot/journals').trim()
                }
				steps {
					sh 'echo Generamos un numero nuevo de snapshot, solo se actualiza el valor 1.1.X' 
					sh 'echo Version ${VERSIONAPI}' 
                	sh 'ansible-playbook snapshot.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			stage('Step 4 - Release & Upload a Nexus') {
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/newrelease/journals').trim()
                }
				steps {
					sh 'echo Generamos un numero nuevo de version ya que se trata de un release' 
					sh 'echo Version ${VERSIONAPI}' 
					sh 'ansible-playbook release.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			stage('Step 5 - Creacion del Docker & Publicacion ') {
				environment { 
                    VERSIONAPI= sh (returnStdout: true, script: 'curl http://jenkins-api.azurewebsites.net/api/values/getlast/journals').trim()
                }
				steps {
					sh 'ansible-playbook docker-publish.yml --extra-vars "version=${VERSIONAPI}"'
				}
			}
			 
    }
}