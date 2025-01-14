FROM node:18-alpine

# Configurar diretório de trabalho
WORKDIR /app

# Copiar arquivos para o contêiner
COPY . .

# Instalar dependências
RUN npm install

# Expor a porta do frontend
EXPOSE 3000

# Rodar o frontend
CMD ["npm", "run", "dev", "--", "--host"]
