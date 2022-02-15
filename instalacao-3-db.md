# Subindo serviço do banco postgres

**Para iniciar precisaremos de 2 arquivos**
- **Dockerfile**
- **docker-compose.yml**

De posse desses arquivos primeiramente vamos fazer o build da nossa imagem do postgres.

```
docker build -t luz-do-saber_banco:latest .
```

Em seguida vamos iniciar o serviço do postgres.
```
docker stack deploy -c docker-compose.yml banco
```

