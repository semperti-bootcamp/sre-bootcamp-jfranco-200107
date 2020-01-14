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
			stage('Step 1 - Configuración') {
				steps {
					sh "./OpenVpn/connect-vpn.sh"
				}
			}
			stage('Step 2 - Unit testing') {
				steps {
					sh "echo TBD"
 					sh "mvn test -f Code/pom.xml"
				}
			}
			stage('Step 3 - Snapshot') {
				steps {
                	sh 'ansible-playbook snapshot.yml --extra-vars "version=$env.VERSION"'
				}
			}
			stage('Step 4 - Release') {
				steps {
					sh 'ansible-playbook release.yml --extra-vars "version=$env.VERSION"'
				}
			}
			stage('Step 5 - Upload a Nexus del artefacto de Maven ') {
				steps {
					sh "echo TBD"
				}
			}
			stage('Step 6 - Creacion del Docker ') {
				steps {
					sh "echo TBD"
				}
			}
			stage('Step 7 - Subir imagen a Docker Hub ') {
				steps {
					sh "echo TBD"
				}
			}		
    }
}