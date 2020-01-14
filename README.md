# Week 01 - Assignments
Repositorio para los assignments de la primer semana.

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
