pipeline {
    agent {
        node (){
            label 'bc-jfranco'
        }
    }
    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'false'
		VERSION = "1.1"
    }

    stages {
			stage('Step 1 - Configuración') {
				steps {
					sh "echo TBD"
				}
			}
			stage('Step 2 - Unit testing') {
				steps {
					sh "echo TBD"
				}
			}
			stage('Step 3 - Snapshot') {
				steps {
					sh "echo TBD"
				}
			}
			stage('Step 4 - Release') {
				steps {
					sh "echo TBD"
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