# Use an official Node.js runtime as a parent image
FROM node:16 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app
RUN npm run build

# Create the final lightweight image
FROM nginx:alpine

# Copy the built app to the nginx web server directory
COPY --from=build /app/dist/* /usr/share/nginx/html/
