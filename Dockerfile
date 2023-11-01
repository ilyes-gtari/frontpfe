# Étape 1 : Builder l'application
FROM node:16 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
# Installer Angular CLI globalement
RUN npm install -g @angular/cli
COPY . .
RUN ng build --configuration=production

# Étape 2 : Utiliser une image NGINX pour servir l'application
FROM nginx:alpine
COPY --from=build /app/dist/* /usr/share/nginx/html/
CMD ["nginx", "-g", "daemon off;"]
