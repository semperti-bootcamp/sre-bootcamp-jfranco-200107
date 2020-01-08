# Week 01 - Bootcamp (Ansible)
# Aprovisionamiento con Ansible

## Prerequisites

	1. Ubunto 18.04+ o Windows 10 Anniversary Update
	2. Internet connection
	
## Windows 10 Anniversary Update - Habilitar SubsystenLinux
Como primer paso se debe abrir una consola de Powershell como administrador, y ejecutar la siguiente instruccion:

```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

Paso siguiente reiniciar el equipo.
Una vez reiniciado se debe ingresar al Store de Microsoft, y buscar alguna distribucion de linux que nos interese, para este caso fue la version 18.04.2 LTS.

## Ambiente de trabajo

Verificamos la version en la que nos encontramos.

```
jsfrnc@DESKTOP-05EMQVA:~$ cat /etc/os-release
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

Debemos actualizar el sistema

```
sudo apt-get update
sudo apt-get upgrade -y
```
 
Si no tenemos pyhon debemos instalarlo ya que ansible lo utiliza
```
sudo apt-get install python -y
```

Agregamos el repositorio de ansible
```
sudo apt-add-repository ppa:ansible/ansible
```
Hacemos una actualizacion
```
sudo apt-get update
```
Instalamos Ansible  
```
sudo apt-get install ansible -y
```

## Configurar acceso mediante SSH
        
En caso de no tener generada unas claves SSH debemos proceder con el siguiente comando
```
ssh-keygen
```
Una vez generada obtenemos la clave
```
cat ~/.ssh/id_rsa.pub
```
Deberiamos tener una clave, la copiamos ya que deberiamos introducir en los proximos pasos.
```
jsfrnc@DESKTOP-05EMQVA:~$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqyzEljkrgzskUu/Ab3IdopGnGYjgUZb3/iN7+2l/pFMXG3rO9rXwTxPHVFVV6z1/0dY5BYHX+9U72PKsFpxi5AdVEmvW81Bo5gHnrYcwuTWMZ2tKZwFvjvawUGR8ZTtEmuF40VL9V+5o+GEuiEI6c0x5UP30w35CGaUQlasg7QnEBFvnQveLoOVfX8NT2VodxAMgSDS09pjsShPwOPHsqeahR1OciiKRMz4/t+8f8lOZOZ/p5qQGaRMsdZEX5WUwc2cJwt/09HbCu4IlI5kMu7cQxlnT0ic3lcgagJ+0cglmE0OiyArsJsx36UuQS0cQ1PUdoO8QjAFm1vX+sYunl jsfrnc@DESKTOP-05EMQVA
```

Ingresamos al nodo y abrimos el archivo de authorized_keys 
```
sudo nano ~/.ssh/authorized_keys.
```
Pegamos la clave y guardamos el archivo.
 
Tambien podriamos usar el comando ssh-copy-id

```
ssh-copy-id user@server
```

En nuestro caso tenemos un dns al bootcamp vm, que es vmbootcamp2020.eastus.cloudapp.azure.com

```
ssh-copy-id jsfrnc@vmbootcamp2020.eastus.cloudapp.azure.com
```

La salida del comando deberia ser similar a este
```
jsfrnc@DESKTOP-05EMQVA:~$ ssh-copy-id jsfrnc@vmbootcamp2020.eastus.cloudapp.azure.com
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/jsfrnc/.ssh/id_rsa.pub"
The authenticity of host 'vmbootcamp2020.eastus.cloudapp.azure.com (52.170.147.176)' can't be established.
ECDSA key fingerprint is SHA256:51IAh9T19llTyhbnVw+emwrmiOO7Cy+fX1BISQTDBcg.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
Password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'jsfrnc@vmbootcamp2020.eastus.cloudapp.azure.com'"
and check to make sure that only the key(s) you wanted were added.
```

Verificamos con entrar al Nodo
```
jsfrnc@DESKTOP-05EMQVA:~$ ssh 'jsfrnc@vmbootcamp2020.eastus.cloudapp.azure.com'
[jsfrnc@vmbootcamp ~]$
```

## Configurar nodos

Dentro de nuestra carpeta de Ansible, editamos los servers.
```
nano servers
```
En nuestro caso estamos usando un DNS, en caso de necesitar podemos agregar mas.
```
[azure]
vmbootcamp2020.eastus.cloudapp.azure.com set_hostname=azure_vm_centos7

[local]

[servers:children]
azure
local
```

Para verificar esto podemos hacer un ping a todos los equipos.
```
jsfrnc@DESKTOP-05EMQVA:~/repos/sre-bootcamp-jfranco-200107/Ansible$ ansible all -m ping
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match
'all'
```

Como no especificamos un archivo de hosts, fue a buscar el de defecto, con el comando -i podemos especificar el archivo servers que modificamos anteriormente.

```
jsfrnc@DESKTOP-05EMQVA:~/repos/sre-bootcamp-jfranco-200107/Ansible$ ansible all -m ping -i servers
vmbootcamp2020.eastus.cloudapp.azure.com | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    },
    "changed": false,
    "ping": "pong"
}
```
Con esto tenemos todos los pasos suficientes para aprovicionar nuestra configuracion.


## Ejecucion del script de Ansible
Se ejecuta el playbook, especificando el archivo yml y el archivo local de nuestros nosotros. Adicionalmente se envia el parametro K para solicitar la contraseña del root.

```
ansible-playbook Environment.yml -i servers -K 
```

# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
