# Step 1: Use the official Node.js image as the base
FROM node:18-alpine AS build

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json files
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application code to the container
COPY . .

# Step 6: Build the React app
RUN npm run build

# Step 7: Use a lightweight web server for the final stage
FROM nginx:alpine

# Step 8: Copy the build output from the previous stage to the Nginx web server
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose the port that the server will run on
EXPOSE 80

# Step 10: Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
