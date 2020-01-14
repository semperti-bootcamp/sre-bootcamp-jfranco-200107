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
            

## Conexion con repositorio de Nexus
Debido a que esta en Azure, no posee visibilidad para el repositorio de Nexus por eso se genero los archivos de conexion e instalar las dependencias de OpenVpn.
```
yum -y install https://as-repository.openvpn.net/as-repo-centos7.rpm
yum -y install openvpn-as
wget -O /etc/yum.repos.d/AL-Server.repo  http://www.alcancelibre.org/al/server/AL-Server.repo
sudo yum -y install openvpn easy-rsa shorewall
sudo yum install openvpn
sudo service openvpnas stop
sudo openvpn --client --config pfsense-UDP4-1194-jfranco-config.ovpn --auth-user-pass auth.txt &
```

## Configuracion del Slave de Jenkings

Creamos un usuario con el cual va a correr nuestro agente, para este caso se va a llamar jenkins
```
sudo useradd -d /var/lib/jenkins jenkins
passwd jenkins

```

Creamos un certificado para conectarnos por SSH
```
su - jenkins
ssh-keygen -t rsa -C "Jenkins agent key"
```

Agregamos la clave como autorizada
```
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
 
```
Copiamos el cotenido de la clave
```
cat ~/.ssh/id_rsa
```
Deberia ser similar a esta

```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA2Q8iBJro3MBi9W3rItSb35fkqY43QTXxaVGlfjHq34Vix/dR
xZ+DWV7HWaN9RKSi9ydfTB6vgWrM6JT7Q9OZLkgMqVnKIONE4cQjVNx47BOPI18L
cEJ6/Ih9iodgLBKh+6vWP1WmvrvuJSfFVbUA7inqVvn9xkOljkVBMoW7qbmZoMaB
hBNPnTbrN3An06DeimG9yV3zVrai4ywtfnP0zmNatXsL9WSM7vV4N6JGZNnqE5g6
eg6/7TqQaNAiTn5phMJahOgtz1NPaEyAwO7trxZSuX6DygLKHAl65vNoE8XWeL4a
SxxeUfK8mS3OSp75W2t7hkdt/i3MFldhWLz2FwIDAQABAoIBAE2Kbmievlk+ERwE
LF/A+/4gUPuRZoPRNXCeTjSKuJEpIWS2IWwr08x1Y1nOYc3H0r/gPNcAj0n4UUM1
FZ3hVXOHIZ7OCLs+9TiBzO1f5YLQae4E4h00YqMcT1zRh7W24k750AvIGU1B7Y0w
a/p2MuLh7mkr3VCakeYFL4lQ5P14O3M/CbyqQfhHU5qOa/pzcc1ctKYf/hTUm/7D
1SSnr4xbrWkR80+aZ5sH4lTrBoyJTp89VuDBCKxmv8QjH5B8pMQZGmhhWheFPW9G
XSNo21LHdE8NvXwgZ1Xz5yKgKv/HtOW5l/UWsJIaPFkcjYpbtY2fvPlfNuRUhAra
QiweMYECgYEA+9kjMdqOiHaYO5+9NwmHCZ2x9GFx/2hFP3GY2NtnjnCjPAtYJYxT
fcpIFijEZco2/r3m3yQ0Yg+dIm4Xfq1xxJTh371F0nAA4r7qjCqFUeiSijenKTVg
clEDQ7ihVP1abfMzLbXFDj1slckMBpzHAQhUI8vBdkrGDBM+j6TAhecCgYEA3KMt
QDnPrDlekSFSNSSO1CwUaA6wSqfGtnc4OY6+rL2W5iWHaAia4xVJeE/kAazKEv/V
xIDC3RWmZOTdQFj3auNkGrbilNW6jgc/RDcsK4wM0z1H7iIQIcAkS6qh4Q00dzO5
kxDJA532cdTNVg8alZe/Abogqrn49Pxsb3wVqFECgYBrl4IfpD1MM04p+r49KwbT
ptkFjDPFZ2heCEvCKUl+YsR5vGb185MfpDFTtirhSZhhEAP3xGHUmtMIiHvlFHgM
AYbVrOiNVGgsdl+BbhDywycHgWsagcEoVU/NuKzDwFDHtCRjHMqIoNkozHEkygmC
eWpouH136c3eDsKlXz8YdQKBgFaqpii3TLL66gGaFB+Z15zSH8XsFyWMF8sus2Aw
iQdzhWWr0i90SdrvTqe6wfZCeDHUWpTQezq6uVyiZaJUEAPlhDnWItSRy7Dked6C
yY/leFg1lx6cNLf9MISkZufu9u/n2npBOqR4FQkLrQij8C5YqAe2pARL/tXEnZeB
J0SxAoGANsd9QreJMmeNhrdlzV3rL41t2RUs5gKP7uC8qcKZhRLUbvJOf7s6Gbep
+6u30xjLnvYUpNyVd/GHoz5HyyyCZohxHwBqug3kHXXzFGawup4bm7ZjPitwKXtX
ywOs1cEYn6kerZETFGtrjm/7DRZn4HwpJHY2Ec3oG7QcR0RXTyo=
-----END RSA PRIVATE KEY-----
```


## Configuracion en el servidor de Jenkins

Ingresamos a nuestro servidor de Jenkins, vamos a Administrar nodos, Nuevo nodo (http://10.252.7.162:8080/computer/).
Seleccionamos que sea un Permanent Agent.
Dentro de los valores de configuracion:
- Nombre, en este caso jfranco
- Directorio remoto /var/lib/jenkins
- Usar: Dejar esta nodo para ejecutar sólamente tareas vinculadas a él
- Metodo de Ejecucion: Arrancar agentes remotos en máquinas Unix vía SSH
- En el nombre de maquina: vmbootcamp2020.eastus.cloudapp.azure.com
- Agregamos un nuevo usuario
  - Ingresamos el usuario jenkins
  - Seleccionamos que tenemos la clave privada: SSH Username with private key
  - Insertamos el valor de la configuracion anterior
- Es importante que en Host Key Verification Strategy pongamos la opcion de Manually trusted key Verification Strategy.

Con eso tendriamos configurado nuestro Slave de Jenkins.

# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
