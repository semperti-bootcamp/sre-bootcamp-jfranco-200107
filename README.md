# Week 01 - Assignments
Repositorio para los assignments de la primer semana.

# Java Application

## Prerequisites

	1. Java 8
	2. Maven 3.3+
	3. MySQL 5.6+
	4. Internet connection
	
	
## Instrucciones para correr esta aplicación

	1. Configurar la conexión de la base de datos desde Code/src/main/resources/application.properties
	2. Ubicate en la carpeta del código y ejecutá "mvn spring-boot:run".
	3. Revisá la siguiente dirección http://localhost:8080
	4. [Opcional] Por defecto, la aplicación almacena los PDFs en el directorio <User_home>/upload. Si querés cambiar este directorio, podés utilizar la propiedad -Dupload-dir=<path>.
	5. [Opcional] Los PDFs predefinidos pueden encontrarse en la carpeta PDF. Si querés ver los PDFs, tenés que copiar los contenidos de esta carpeta a lo definido en el paso anterior.
	
## Datos de autenticación

	El sistema viene con 4 cuentas pre-definidas:
		1. publishers:
			- username: publisher1 / password: publisher1
			- username: publisher2 / password: publisher2
		2. public users:
			- username: user1 / password: user1
			- username: user2 / password: user2


## Configuracion de Nexus
Se debe modificar la configuracion local de Maven, el archivo conf/settings.xml en linux se encuentra en /usr/local/maven/conf en windows depende la carpeta que se selecciono.

```
	<server>
		<id>snapshots</id>
		<username>Bootcamp</username>
		<password>Bootcamp1!</password>
	</server>
	<server>
		<id>releases</id>
		<username>Bootcamp</username>
		<password>Bootcamp1!</password>
	</server>
```
Para la creacion de los snapshots se deja los comandos

```
mvn versions:set -DnewVersion=8.8-SNAPSHOT
mvn clean deploy

```

```
#release
mvn versions:set -DnewVersion=8.9
mvn clean deploy
```

Hay un archivo de ejemplo en Docs/mvn.conf.settings.xml
            
# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
