# GitOps
## Tareas
-  9.0	Se debe realizar la configuración de un Manifest en GitHub
-  9.1	La modificación del Manifest, sólo deberá afectar el ambiente elegido [tiene que haber, al menos, dos ambientes distintos (staging/prod)]
-  9.2	Debe ejecutarse automáticamente, tras únicamente, la modificación del Manifest y SOLO del ambiente elegido

**Informaación Adicional**
Este branch funciona a modo de master, el modelo que se baso es en Trunk-Based Development.

El desarrollo basado en Trunk-Based Development es la clave de la integración continua y, por extensión, la entrega continua. Cuando las personas de un equipo realizan sus cambios en el trunk varias veces al día, resulta fácil satisfacer el requisito central de la integración continua de que todos los miembros del equipo se comprometan con el trunk al menos una vez cada 24 horas. Esto garantiza que la base de código siempre se pueda liberar a pedido y ayuda a hacer realidad la entrega continua.

La línea divisoria entre el desarrollo basado en trunk de equipos pequeños y el desarrollo basado en trunk a escala está sujeta al tamaño del equipo y a la consideración de la tasa de compromiso. El momento preciso en que un equipo de desarrollo ya no es "pequeño" y ha pasado a ser "escalado" está sujeto a debate profesional. En cualquier caso, los equipos realizan una compilación completa de "preintegración" (compilación, pruebas unitarias, pruebas de integración) en sus estaciones de trabajo de desarrollo antes de comprometerse / presionar para que otros (o bots) lo vean.

![Trunk-Based Development For Smaller Teams](https://trunkbaseddevelopment.com/trunk1b.png "Trunk-Based Development For Smaller Teams")

https://trunkbaseddevelopment.com

**La liberación del release deberia funcionar a base de la integracion de los branch y un tag asociado.**

## Configuracion de Jenkins

- Se creo una nueva tarea journals-multibranch-pipeline del tipo Multibranch Pipeline.
- Se agrega repositorio y expresion regular para los repositorios asociados, en este caso fue ```^(.*task10).*$```
```
En procesoScan Multibranch Pipeline Log
Started
[Wed Jan 15 23:27:05 ART 2020] Starting branch indexing...
 > git --version # timeout=10
using GIT_ASKPASS to set credentials test
 > git ls-remote https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107.git # timeout=10
 > git rev-parse --is-inside-work-tree # timeout=10
Setting origin to https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107.git
 > git config remote.origin.url https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107.git # timeout=10
Fetching & pruning origin...
Listing remote references...
 > git config --get remote.origin.url # timeout=10
 > git --version # timeout=10
using GIT_ASKPASS to set credentials test
 > git ls-remote -h https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107.git # timeout=10
Fetching upstream changes from origin
 > git config --get remote.origin.url # timeout=10
using GIT_ASKPASS to set credentials test
 > git fetch --tags --progress origin +refs/heads/*:refs/remotes/origin/* --prune
Checking branches...
  Checking branch task10-master
      ‘Jenkinsfile’ found
    Met criteria
Scheduled build for branch: task10-master
  Checking branch task10-staging
      ‘Jenkinsfile’ found
    Met criteria
Changes detected: task10-staging (070570ca8e54b724970ebccc4ed36b22b7181a0c → cd35c717dd690df8d28409926c09830fa516c7df)
Scheduled build for branch: task10-staging
Processed 11 branches
[Wed Jan 15 23:27:08 ART 2020] Finished branch indexing. Indexing took 2.8 sec
Finished: SUCCESS
```

>Se modifico el Jenkinsfile para separar la logica de los Snapshot que se deberian generar el el branch de staging y los de release del master.

# Contact

Cualquier duda o consulta, ubicanos en [Slack](https://semperti.slack.com).
