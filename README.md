# Week 01 - Assignments
Repositorio para los assignments de la primer semana.

# Terraform (VM Machine)
Información necesaria para la creacion del ambiente.
[link](TF/README.md)

# Java Application

## Prerequisites

	1. Java 8
	2. Maven 3.3+
	3. MySQL 5.6+
	4. Docker Desktop
	5. Internet connection
	
	
## Instrucciones para correr esta aplicación

	1. Configurar la conexión de la base de datos desde Code/src/main/resources/application.properties
	2. Ubicate en la carpeta del código y ejecutá "mvn spring-boot:run".
	3. Revisá la siguiente dirección http://localhost:8080
	4. [Opcional] Por defecto, la aplicación almacena los PDFs en el directorio <User_home>/upload. Si querés cambiar este directorio, podés utilizar la propiedad -Dupload-dir=<path>.
	5. [Opcional] Los PDFs predefinidos pueden encontrarse en la carpeta PDF. Si querés ver los PDFs, tenés que copiar los contenidos de esta carpeta a lo definido en el paso anterior.

## Instanciar mvn en centos sin cerrarse

	1. En la carpeta del codigo ejecuta
```
	nohup mvn spring-boot:run &
```
	
## Datos de autenticación

	El sistema viene con 4 cuentas pre-definidas:
		1. publishers:
			- username: publisher1 / password: publisher1
			- username: publisher2 / password: publisher2
		2. public users:
			- username: user1 / password: user1
			- username: user2 / password: user2


## Instalacion de Docker
- Si estan en Centos, siguen el siguiente script:
```
sudo yum check-update
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker
sudo systemctl start docker
sudo systemctl enable docker
```
- Si estan en Windows, pueden descargarlo desde https://docs.docker.com/docker-for-windows/install/

## Pasos para generar el contendor
Como primer paso nos debemos encontrar en el raiz del proyecto, donde se encuentra el dockerfile, y procedemos a hacer el build de la imange. En el parametro {NAME} deberia ir el nombre de nuestra imagen.



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

            
```
docker build --rm -  -t {NAME} .
docker build --rm --no-cache -t {NAME} .
```
Por ejemplo journals

```
docker build --rm --no-cache -t journals .
```

Para comprobar que funciono todo correctamente, podemos listar las imagenes en el sistema.


```
docker images
```

El proximo paso es ejecutar el contenedor, referenciando a la imagen que construimos previamente. Para esto vamos a tener que generar un nombre para nuestro contenedor (--name), en caso de querer redireccionar puertos del contenedor a nuestra maquina (-p) y referenciamos al nombre de la imagen (-ti).
```
docker run --privileged --name journals_app  -p 8080:8080 -ti journals 
```

En caso de fallar, y querer entrar iterativamente a nuestro contenedor podemos usar el comando -it y setearle un --entrypoint para acceder y poder verificar temas de configuracion.

```    
docker run -it --entrypoint /bin/sh --privileged --name journals_app  -p 8080:8080 -ti journals
```
Si queremos que el mismo funcione detachado a nuestro simbolo de sistema, solo falta adicional el parametro -d.

```
docker run -d --privileged --name journals_app  -p 8080:8080 -ti journals    
```

### Publicar container en Azure
1. Tuvimos que crear un Registros de contenedor, para esta prueba fue semperti.azurecr.io.
2. Se habilito el acceso de adminstracion, para obtener el usuario y contraseña.
3. Desde la consola realizamos un 
```
docker login semperti.azurecr.io
```
4. Buscamos la imagen a subirla al registro
```
docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
jsfrnc/semperti-bootcamp   firsttry            afaa7c0506e7        2 hours ago         834MB
```
5. Hicimos un tag de la misma
```
docker tag afaa7c0506e7 semperti.azurecr.io/journals
```
6. Hicimos un push
```
docker push  semperti.azurecr.io/journals
The push refers to repository [semperti.azurecr.io/journals]
9269dc392487: Pushing [==================================================>]  35.88MB
2fb9d21a73e6: Pushing [==================================================>]  39.35MB
be230368975c: Pushed
6831f6961390: Pushed
497269e0b369: Pushed
9cabc3fe13d9: Pushing [======================>                            ]  38.74MB/85.23MB
548034a34f42: Pushing [========================>                          ]  211.7MB/433.9MB
e3a37bc06bf3: Pushing [====================================>              ]  89.64MB/121.5MB
```
7. Una vez alojado el contenedor, debemos vincularlo a un plan de tarifas  de azure para que este disponible y nos informe la url finalizada (Se puede utilizar Visual Code).
8. Queda disponible en una web del estilo: 


# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).


# Resumen de actividades

## General
- 0.0	Generar un repositorio dentro de https://github.com/semperti-bootcamp y generar un commit con los archivos iniciales del repo original SIN MODIFICACIONES
- 0.1	El nombre debe respetar la siguiente nomenclatura: sre-bootcamp-name-<YYMMDD>  --> La fecha debe ser el día de inicio del Bootcamp
- 0.2	Se debe generar un branch por cada assignment
- 0.3	Sólo deben generarse PRs con los archivos MODIFICADOS contra el repositorio generado en el punto 0.0
- 0.4	Se debe setear como resuelto en Zoho Sprint con el vínculo al PR
- 0.5	Siempre se debe incluir un Readme.md con toda la información necesaria para evaluar el trabajo realizado [pasos para probar, inconvenientes encontrados, etc.]

Resultado
> Se creo el repositorio https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107		

## Crear VM con Terraform
-  1.0	La VM no debe tener más que 2 cores y 2 GB de RAM
-  1.1	La VM debe tener CentOS7
-  1.2	La VM debe ser accesible mediante VPN
-  1.3	La VM debe poder conectarse a internet

Resultado
> Ya se solicito un PR, https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/pull/1 .

> Plan de terraform -> https://drive.google.com/file/d/1fbmAgi8BrPLOCbP7nhOMJEbl2PeN59KM/view?usp=sharing .

> Output de terraform -> https://drive.google.com/file/d/1j8OukUsEymJ9K3Nfq-DKJJT6jNSKSX5L/view?usp=sharing .

**Informaación Adicional**
> Readme.md del branch :  [/TF/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task2-terraform-vm/TF/README.md).


## Configurar VM con Ansible
-  2.0	Deben configurarse todos los elementos solicitados [Java 8, Maven, MySQL, etc.]
-  2.1	Deben proveerse screenshots validando los paquetes instalados
-  2.2	Deben proveerse los scripts de configuración
-  2.3	Deben describirse todos los pasos y requerimientos para ejecutar el script de Ansible

Resultado
> Se genero el branch task3-ansible con los cambios solicitados.

> Ya se solicito un PR, https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/pull/2

> Tambien existe un nuevo archivo readme.md dentro de la carpeta Ansible con la informacion necesaria para ejecutar este caso.

> Output -> https://drive.google.com/file/d/15sIBrs36nlZuypMtIM_65khMlzROQZQE/view?usp=sharing

> Output -> https://drive.google.com/file/d/1zRLInrXsy5xACLKNGu7x8mS8vw5X9XPM/view?usp=sharing

> Checking del software instalado -> https://drive.google.com/file/d/1zEoJ2M7w7jSiD7UTpKvfDl72iAii7f_4/view?usp=sharing

> Operacion completa -> https://drive.google.com/file/d/1G1L5c_oAB0BQD8cT1XvRacE6J06dbBz1/view?usp=sharing

> Se hizo un commit adicional, por un problema con la version de maven. Se sube evidencia adicional https://drive.google.com/file/d/1mm8AGcIiH9Ci6nD_2UKlpqeKIVHYmu_M/view?usp=sharing

**Informaación Adicional**
> Readme.md del branch :  [/Ansible/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task3-ansible/Ansible/README.md).

## Probar aplicación Java
-  3.0	Se debe proveer un link de acceso a la aplicación
-  3.1	Debe quedar 100% funcional [crear un jornal (PDF), ver PDFs previos, etc]
-  3.2	Debe pasar el testeo de Maven

Resultado
> La aplicacion quedo disponible en http://vmbootcamp2020.eastus.cloudapp.azure.com:8080

> Se detecto que por el tamaño de maquina que se eligio para el script de tf, no permitia levantar por mvn la aplicacion.

> Se adjunta evidencia del build -> https://drive.google.com/file/d/1pK0Axedv7nowF8_Si-0fADO3byWRu-7j/view?usp=sharing

> Se adjunto evidencia del test ->  https://drive.google.com/file/d/13nsI-LJ0NR9ffWE18qWNs-BEKWTbMoYs/view?usp=sharing

> Compilacion local -> https://drive.google.com/file/d/1EAjYDkfAQKQHkssbLH3qtzgrxqC8zATb/view?usp=sharing

> Testing local -> https://drive.google.com/file/d/1IXGTQS1Agol7p4WCXsL_Pp-cqsQqgs06/view?usp=sharing

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task4-appjava/README.md).

## Cargar Aplicación Java en repositorio Nexus
-  4.0	Se debe cargar en Nexus un snapshot de la aplicación Java
-  4.1	Se debe cargar en Nexus un release de la aplicación Java
-  4.2	Se deben realizar mediante un script de Ansible
-  4.3	Se debe proveer todos los archivos necesarios para realizar estas tareas

Resultado
> Se genero el branch task5-ansible con los cambios solicitados.		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task5-nexus/README.md).

## Dockerizar aplicación Java
-  5.0	Se debe proveer el Dockerfile y los archivos necesarios para generar la imagen
-  5.1	Debe quedar corriendo el container
-  5.2	Debe proveerse un link para probar el funcionamiento del contenedor

Resultado
> Se genero el branch task6-docker con los cambios solicitados.		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task6-docker/README.md).

## Subir Docker Image a Nexus
-  6.0	La imagen de Docker debe quedar accesible desde Nexus
-  6.1	Se debe proveer el comando para subir una imagen a Nexus junto con un comando para descargar la imagen y correr el contenedor
-  6.2	Debe proveerse el sistema lógico de taggeo de imágenes

Resultado
> Evidencia de publicacion de imagen en Docker Hub -> https://hub.docker.com/layers/jsfrnc/semperti-bootcamp/firsttry/images/sha256-8376360c4a63a30e65a9a0abda9871e2db7e05127929bccfe7e30973f4817351

> Output de publicacion -> https://drive.google.com/file/d/1KMfY5dYV0ILR1gJUsSI482ggYua18cex/view?usp=sharing

> Descarga y ejecucion de imagen -> https://drive.google.com/file/d/10QQ9dqkUTd1jAC3n9H289haYkj2xz1Ev/view?usp=sharing

> Script de Ansible -> https://drive.google.com/file/d/1sDRquwKhaKKhQBtqzG-dTUyBVnBwByTb/view?usp=sharing

> Repo con los distintos tags -> https://hub.docker.com/repository/docker/jsfrnc/bootcamp-journals/tags?page=1
		
**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task7-publish-dockerhub/README.md).

## Crear Pipeline de CI
-  7.0	Debe encontrarse dentro de un folder con el nombre bc-username
-  7.1	Debe ejecutarse el build cada vez que se realice un PR
-  7.2	Debe contener al menos, las etapas de configuración, unit testing, snapshot, release, upload a Nexus del artefacto de Maven y de la imagen de Docker
-  7.3	Debe ejecutarse en un Jenkins slave propio

Resultado
> Se genero el Pipeline y se uso como slave la maquina que se levanto en azure. 

>  Resultado del build -> https://drive.google.com/file/d/1OfvvhFAOncbLZ9ueIkYqB01FtJLCw7rb/view?usp=sharing

>  El mismo genera una nueva version del snapshot y release, sube los artefactos a Nexus.

>  Arme una api para generar el id autoincremental.

> Jenkins http://10.252.7.162:8080/job/bc-jfranco/"		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task8-jenkins/README.md).

## Crear Pipeline de CD
-  8.0	Debe encontrarse dentro de un folder con el nombre bc-username
-  8.1	Debe ejecutarse el build cada vez que se realice un PR
-  8.2	Debe contener al menos las etapas de descarga de imagen, ejecución de contenedor y prueba de acceso a la aplicación mediante un curl y su output

Resultado
> Se creo una task para el CD en journals-CD.

> A traves de la API obtiene el numero de version, baja esa imagen y hace las pruebas correspondientes.

> Jenkins http://10.252.7.162:8080/job/bc-jfranco/.	

**Informaación Adicional**
> N/A

## GitOps
-  9.0	Se debe realizar la configuración de un Manifest en GitHub
-  9.1	La modificación del Manifest, sólo deberá afectar el ambiente elegido [tiene que haber, al menos, dos ambientes distintos (staging/prod)]
-  9.2	Debe ejecutarse automáticamente, tras únicamente, la modificación del Manifest y SOLO del ambiente elegido

Resultado
> **En curso**

**Informaación Adicional**
> TBD.