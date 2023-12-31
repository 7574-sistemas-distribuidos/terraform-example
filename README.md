# cloud-example
Conjunto de ejemplos de componentes Cloud para ilustrar conceptos básicos de infraestructura distribuida.
Se utiliza Google Cloud Platform (GCP) como proveedor

## Pre-requisitos
Los ejemplos requieren de los siguientes elementos:
- Terraform instalado en el equipo que despliega los recursos
- Existencia de un proyecto GCP con capacidad para crear los recursos IaaS y PaaS de ejemplo
- Existencia de una cuenta de servicio en GCP con credenciales almacenadas en el archivo json con permisos para realizar el despliegue de los recursos
- Existencia de un bucket previamente creado para alojar ejemplos de código, compilación y salidas de ejecuciones (puede crearse automáticamente, pero el borrado accidental de archivos no se puede deshacer).

## IaaS
Se consideran los siguientes recursos de ejemplo:
- **Cloud Storage:** bucket con objetos utilizados para compilación de _container images_ y despliegue de _cloud functions_.
- **Compute Engine:** instancias de cómputo con scripts de inicialización.
- **VPC Network:** _virtual private clouds_ (VPCs), redes de _firewall_ y _routes_.

## PaaS
Se consideran los siguientes recursos de ejemplo:
- **Cloud Function**: funciones Python que responden a pedidos HTTP.

## Ejecución
1. Crear el archivo de variables básicas de configuración a partir del ejemplo incluido:
```
cp terraform.tfvars.example terraform.tfvars
```
1. Completar los valores de `project_id`, `credentials_path` y `bucket_name` requeridos en el archivo `terraform.tfvars`.
1. Inicializar el directorio de trabajo de Terraform:
```
terraform init
```
1. Importar estado del _storage_ para evitar el intento de creación:
```
terraform import module.storage.google_storage_bucket.default <BUCKET-NAME>
```
1. Revisar el plan de ejecución de despliegue
```
terraform plan
```
1. Ejecutar el despliegue de recursos IaaS:
```
terraform apply -target=module.networking -target=module.web_servers
```
1. Ejecutar el despliegue de recursos PaaS:
```
terraform apply -target=module.boundaries -target=module.controllers
```
1. Eliminar todos los recursos creados:
```
terraform destroy -target=module.boundaries -target=module.controllers -target=module.networking -target=module.web_servers
```

