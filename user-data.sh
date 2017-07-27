#!/usr/bin/env bash
#Se usa set para ver la ejecucion del script linea por linea. en caso de ayuda
#set -e -x
#El id de la instancia que corre el script automatizar este paso.
instance_ids="i-08x58x4x478x1"
# El /etc/profile se declaran las variables accesibles para todos los usuarios del sistema.  
expose_file="/etc/profile.d/expose.sh"
# Fichero para guardar los log o salidas del script
log_file="/opt/init/ec2/user-data.log"
# Comando que obtiene la ip publica  de la instancia que cambia en cada stop y start de la aplicacion
ip_public=$(aws ec2 describe-instances --instance-ids $instance_ids --query 'Reservations[*].Instances[*].PublicIpAddress' --region 'us$
dns_public_name=$(aws ec2 describe-instances --instance-id i-0xa5x64xx8a4x1 --query 'Reservations[*].Instances[*].PublicDnsName' --r$
#Crear el fichero donde estan los comandos para exportar las variables hacia /etc/profile
touch $expose_file
chmod +x $expose_file
echo export PUBLIC_IP_ADDRESS="$ip_public" > $expose_file
echo export PUBLIC_DNS_NAME="$dns_public_name" >> $expose_file
echo "$ip_public" > $log_file
echo "$dns_public_name" >> $log_file
# Ejecuta el /etc/profile sin la necesidad que un usuario inicie session. Analizar implicaciones de seguridad. 
source "/etc/profile"

