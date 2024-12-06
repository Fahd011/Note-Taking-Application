# Stage 1: Build the React app
FROM node:20 as build
WORKDIR /usr/src/app

# Copy package.json and package-lock.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app's source code and build the React app
COPY . .
RUN npm run build

# Debugging step to verify the dist directory exists
RUN ls -la /usr/src/app/dist

# Stage 2: Serve the built app with Nginx
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

# Remove the default Nginx static files and copy the React app's build
RUN rm -rf ./*
COPY --from=build /usr/src/app/dist .

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
