# Imagen base de Node.js
FROM node:18-alpine as build

# Definir directorio de trabajo
WORKDIR /app

# Copiar dependencias y archivos
COPY package.json yarn.lock ./
RUN yarn install

# Copiar el resto del código
COPY . .

# Construir la app de producción
RUN yarn build

# Etapa final: servir con un servidor liviano
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
