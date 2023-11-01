# Étape 1 : Builder l'application
FROM node:16 as build
WORKDIR /app
COPY package*.json ./
RUN npm install --force
RUN npm install -g @angular/cli --force
COPY . .
RUN ng build --configuration=production

# Étape 2 : Utiliser une image NGINX pour servir l'application
FROM nginx:alpine
COPY --from=build /app/dist/* /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
