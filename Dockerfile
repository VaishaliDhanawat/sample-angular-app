# Use the official Node.js image.
FROM node:18 AS build

# Set the working directory. 
WORKDIR /app  

# Copy the package.json and package-lock.json
COPY package*.json ./  
 
# Install dependencies.  
RUN npm install  

# Copy the rest of the application code.
COPY . .

# Build the Angular application.
RUN npm run build --prod

# Stage 2: Serve the Angular app.
FROM nginx:alpine

# Copy the Angular build artifacts from the build stage.
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80.
EXPOSE 80

# Start Nginx.
CMD ["nginx", "-g", "daemon off;"]
