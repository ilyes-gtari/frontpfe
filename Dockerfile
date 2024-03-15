# Étape de construction
FROM node:18.13 as build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances du package.json et du package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install --force

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application Angular
RUN npm run build

# Étape de production
FROM nginx:latest

# Copier les fichiers de construction de l'étape de construction vers le répertoire d'accueil de Nginx
COPY --from=build /app/dist/* /usr/share/nginx/html/

# Exposer le port 80 pour accéder à l'application
EXPOSE 80

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]

