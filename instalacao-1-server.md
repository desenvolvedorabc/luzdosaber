# Preparação da Maquina para receber docker e Aplicação

### swapoff -a to disable swapping
```
swapoff -a

```

### sed to comment the swap partition in /etc/fstab
```
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab
```

### Aumentando o numero de arquivos abertos pelo sistema
```
sysctl -w fs.file-max=806154

echo "fs.file-max = 806154
" >> /etc/sysctl.conf

ulimit -n 806154

echo 'www-data soft nofile 806154
www-data hard nofile 806154
* soft nofile 806154
* hard nofile 806154' > /etc/security/limits.conf
```
### Ajustando TimeZone
```
timedatectl set-timezone America/Fortaleza

```
### Instalando Pacotes Necessário para Docker
```
apt-get update && apt-get install -y net-tools vim apt-transport-https ca-certificates curl software-properties-common nfs-client

```
### Add Docker’s official GPG key
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
```

### Add Docker apt repository
```
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

### Install Docker CE
```
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
```

### Setup daemon
```
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d
```
### Restart docker.
```
systemctl daemon-reload
systemctl restart docker
```

### Iniciando Orquestador de Container
```bash
docker swarm init 

```
### Criando Network do cluster
```
docker network create -d overlay traefik-public --subnet=172.16.0.0/16 --gateway=172.16.0.1
```

**Assim o servidor está pronto para receber as aplicações**
