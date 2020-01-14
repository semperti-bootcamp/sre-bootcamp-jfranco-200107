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

## Configuracion de Maven
Deberiamos detectar el archivo de Settings de Maven
```
[jsfrnc@vmbootcamp ~]$ mvn -X
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: /opt/maven
Java version: 1.8.0_232, vendor: Oracle Corporation, runtime: /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "3.10.0-1062.9.1.el7.x86_64", arch: "amd64", family: "unix"
[DEBUG] Reading global settings from /opt/maven/conf/settings.xml
[DEBUG] Reading user settings from /home/jsfrnc/.m2/settings.xml
[DEBUG] Reading global toolchains from /opt/maven/conf/toolchains.xml
[DEBUG] Reading user toolchains from /home/jsfrnc/.m2/toolchains.xml
[DEBUG] Using local repository at /home/jsfrnc/.m2/repository
[DEBUG] Using manager EnhancedLocalRepositoryManager with priority 10.0 for /home/jsfrnc/.m2/repository
```
Vamos a editar el archivo /home/jsfrnc/.m2/settings.xml
```
sudo nano /home/jsfrnc/.m2/settings.xml
```

Ingresamos la configuracion para los repositorios de Nexus
```
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://10.252.7.162:8081/repository/maven-public/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
  <servers>
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
  </servers>
</settings>
```




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

Hay un archivo de ejemplo en Docs/mvn.conf.settings.xml

Para la creacion de los snapshots se deja los comandos

```
mvn versions:set -DnewVersion=1.1-SNAPSHOT
mvn clean deploy

```

```
#release
mvn versions:set -DnewVersion=1.1
mvn clean deploy
```

Para agilizar este proceso, se genero
```
ansible-playbook snapshot.yml --extra-vars "version=1.1"
```
```
ansible-playbook release.yml --extra-vars "version=1.1"
```

 
            
# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
