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



## Publicar imagen en DockerHub

Como primer paso debemos tener cuenta en Docker y un repositorio.
En caso de no tener alguno de los dos, ingresamos a hub.docker.com, nos registramos y presionamos en la opcion de create repository.

Por consola realizamos el login

```
docker login --username=jsfrnc

```
Listamos las imagenes que tenemos en el sistema, deberiamos tener la que ya generamos en los ejercicios anteriores (journals), si revisamos su IMAGE ID es afaa7c0506e7 este valor lo vamos a usar adelante.
```
docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
journals              latest              afaa7c0506e7        23 minutes ago      834MB
anapsix/alpine-java   8_server-jre        f8388f56eae6        11 months ago       126MB

```

Ahora generamos el tag del numera de imagen, contra el repositorio remoto, el mismo es formado con el @user/@repository_name.

```
docker tag afaa7c0506e7 jsfrnc/semperti-bootcamp:firsttry

```
Una vez realizado esto, hacemos el push de nuestro tag.

```
docker push jsfrnc/semperti-bootcamp:firsttry
The push refers to repository [docker.io/jsfrnc/semperti-bootcamp]
9269dc392487: Pushed
2fb9d21a73e6: Pushed
be230368975c: Pushed
6831f6961390: Pushed
497269e0b369: Pushed
9cabc3fe13d9: Pushed
548034a34f42: Pushed
e3a37bc06bf3: Mounted from anapsix/alpine-java
767f936afb51: Mounted from anapsix/alpine-java
firsttry: digest: sha256:8376360c4a63a30e65a9a0abda9871e2db7e05127929bccfe7e30973f4817351 size: 2212

```
Si tuvimos existo la misma ya deberia estar en nuestro repositorio de Docker Hub, por ejemplo para este caso quedo publicado en https://hub.docker.com/layers/jsfrnc/semperti-bootcamp/firsttry/images/sha256-8376360c4a63a30e65a9a0abda9871e2db7e05127929bccfe7e30973f4817351

Para algunos casos, si quisieramos exportar nuestra imagen en tar podriamos hacer lo siguiente:
```
docker save afaa7c0506e7 > semperti-bootcam.tar 

```

Para importarla seria de la siguiente manera.
```
docker  load --input semperti-bootcam.tar 

```
            

## Descargar imagen de DockerHub
Buscamos la imagen a usar, en este caso vamos a usar la que publicamos en el caso anterior jsfrnc/semperti-bootcamp:firsttry. 

```
docker pull jsfrnc/semperti-bootcamp:firsttry
firsttry: Pulling from jsfrnc/semperti-bootcamp
169185f82c45: Pull complete
390eaa747a6b: Downloading [===========>                                       ]  10.41MB/46.51MB
12116bdc6872: Downloading [==========>                                        ]  12.32MB/58.59MB
4b9c6521136c: Downloading [============>                                      ]  16.09MB/63.11MB
955786db6e7a: Waiting
7863b0acb235: Waiting
55e6c8b76ec4: Waiting
ae5b84ee592e: Waiting
4fda7eef105f: Waiting
```
Una vez descargada listamos las imagenes que tenemos local, y copiamos el image id.

```
docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
jsfrnc/semperti-bootcamp   firsttry            afaa7c0506e7        About an hour ago   834MB
```

Ahora iniciamos con docker un nuevo container haciendo referencia a nuestra imagen -ti {IMAGE ID}
```
docker run  --privileged --name journals_app  -p 8080:8080 -ti afaa7c0506e7
```

A disfrutar!



## Ansible para automatizar la publicación


```
ansible-playbook docker-publish.yml --extra-vars "version=1.1"
```


# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
