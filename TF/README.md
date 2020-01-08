# Week 01 - Terraform
Repositorio con los scripts de TerraForm (Escenario Azure)

# Java Application

## Prerequisites

	1. Terraform
	2. CLI Azure
	3. Poseer subscription_id, client_id, client_secret, tenant_id de nuestra subcripcion de azure a utilizar.
	4. Internet connection
	
## Instalar Terraform
Ingresar al sitio oficial y descargar el aplicativo https://www.terraform.io/downloads.html.
Configurar el path en donde se encuentre el binario.
	
## Instalar CLI Azure
Abri una consola de Powershell con permisos de adminsitracion e instalar el Azure CLI

```
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
```

## Obtener los datos de contexto de nuestra subscripcion de Azure
Abrir una consola de Powershell, y utilizar el Azure CLI para loguearnos.

```
az login
```

Esto nos va a brindar los siguientes datos de referencia

```
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "id": "b72d1359-0000-0000-0000-43fc9bd01e2d",
    "isDefault": true,
    "name": "Pay-As-You-Go",
    "state": "Enabled",
    "tenantId": "9233941b-0000-0000-0000-c0253875b19d",
    "user": {
      "name": "jsfrnc@gmail.com",
      "type": "user"
    }
  }
]
```

Debemos setear en que subscripcion nos encontramos, en el resultado anterior la propiedad id se refiere a nuestra subscripcion.

```
az account set --subscription="b72d1359-0000-0000-0000-43fc9bd01e2d"
```

Se crea un rol como contributor
```
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/b72d1359-0000-0000-0000-43fc9bd01e2d"
```
Esto nos va a generar una salida con los datos para usar dentro de Terraform

```
Creating a role assignment under the scope of "/subscriptions/b72d1359-0000-0000-0000-43fc9bd01e2d"
{
  "appId": "165e118e-0000-0000-0000-9d8b010f953f",
  "displayName": "azure-cli-2020-01-07-20-25-40",
  "name": "http://azure-cli-2020-01-07-20-25-40",
  "password": "f997314b-0000-0000-0000-91fbfd9c2eb1",
  "tenant": "9233941b-0000-0000-0000-c0253875b19d"
}
```

Estos valores los mapeamos en Terraform de la sigueinte manera:
	-	appId es el client_id.
	-	password es el client_secret.
	-	tenant es el tenant_id.

## Instrucciones para correr esta aplicación

	1. Se debe generar un archivo terraform.tfvars como base de terraform.example.tfvars.
	2. Configurar los pametros:
    - azure_subscription_id 
    - azure_client_id        
    - azure_client_secret    
    - azure_tenant_id       
    - vm_admin_username  
    - vm_admin_password 

	3. Impactar los cambios desde terraform.
            
# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
