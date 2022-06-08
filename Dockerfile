# Seleciona a imagem base para a criação da nossa imagem
FROM node:12

# Define a pasta de trabalho de "destino" na imagem a ser criada
WORKDIR /app

# COPY recebe 2 parâmetros: o item que está na origem, ou seja, na máquina
# local, e o local na imagem (no caso, dentro de /app) onde o item será
# copiado
COPY package*.json ./

# RUN executa um comando na imagem, da mesma forma que executamos em nossa
# máquina local
RUN npm install

# Copiamos todo o conteúdo de nossa pasta local para o WORKDIR da imagem (que,
# no caso, é a pasta /app)
COPY . .

# ENV define uma variável de ambiente na imagem (no caso, porta a ser
# utilizada)
ENV PORT=8080

# ???
EXPOSE 8080

# Só pode haver um comando CMD por dockerfile.
# Esse comando é o início da execução da aplicação de fato.
CMD ["npm", "start"]

# Nesse ponto, o dockerfile está completo.
# Para criar a imagem, usamos o seguinte comando:

#   docker build -t <nome_da_imagem> <path_to_dockerfile>

# É preferível criar um username na dockerhub para, então, usar o nome da
# imagem acima no seguinte formato:

#   <nome_da_imagem> = <username>/<image_name>:<version> .

# Após a criação da imagem, o docker criará um hash para ela.
# Por exemplo, dad237435136

# Para executar a imagem (que causa a criação de um container), utilizar o
# seguinte comando:

#   docker run <hash_da_imagem>

# Exemplo:

#   docker run 3049691fff3f

# Porém, nesse exemplo, precisamos mapear a porta 8080 utilizada pelo container
# para uma porta na nossa máquina local, através do seguinte argumento:
#   -p <porta_local>:<porta_container>

# Portanto, o comando final fica assim:

#   docker run -p 5000:8080 3049691fff3f

# Se quisermos persistir os mesmos arquivos entre vários containers, usamos os
# Volumes.

# Um Volume é um diretório dedicado na máquina local, em que podemos criar
# arquivos. Esses arquivos poderão ser montados em containers futuros ou
# compartilhados entre vários containers simultaneamente.

# Para criar um Volume, usamos o seguinte comando:

#   docker volume create <nome_do_volume>

# Após isso, o docker tem um Volume criado em ???

# Para fazer com que um container (ou "mapeie") utilize o Volume, executar o
# docker run da seguinte forma:

#   docker run --mount source=<nome_do_volume>,target=<diretorio_no_container>

# Para inspecionar um container em execução, há 2 formas:

#   1 - Pelo dashboard do Docker Desktop; ou
#   2 - Pelo comando "docker exec".

# De ambas as formas, um terminal é aberto no diretório raiz do container.

# O ideal é mantermos apenas um processo por container.
# Para gerir vários containers, utilizandos o docker-compose.

# Para usar o compose, criamos um arquivo chamado docker-compose.yml, no mesmo
# diretório em que temos o Dockerfile.

# Após definir o docker-compose.yml, usamos o seguinte comando para executar
# todos os containers (deve ser executado de dentro do diretório onde se
# encontram os arquivos docker-compose e Dockerfile):

#   docker-compose up