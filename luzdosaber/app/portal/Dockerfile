# estágio de compilação
FROM node:12.22.5-stretch as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build:web

# estágio de produção

FROM node:alpine production-stage
#Setando LOGLEVEL=INFO-WARN
ENV NPM_CONFIG_LOGLEVEL warn
#Cria o diretorio da aplicação
WORKDIR /usr/src/app
COPY ./webserver .
COPY --from=build-stage /app/dist/web /dist

##Instalacao e Dependencias
#Copia package* para o workdir
COPY ./webserver/package*.json ./
RUN npm install
# replace this with your application's default port
EXPOSE 80
CMD [ "node", "server.js" ]
