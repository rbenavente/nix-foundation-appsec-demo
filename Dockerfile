FROM node:14.21-alpine

# install simple http server for serving static content
RUN npm install -g http-server

# make the 'app' folder the current working directory
WORKDIR /app

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# copy both 'babel.config.js'
COPY babel.config.js ./

# install project dependencies
RUN npm install
RUN echo "AZURE_CLIENT_ID=037aa433-b922-4829-224d-98945ecd52fe\n// AZURE_CLIENT_SECRET=W4I8Q~2FXXNrvznED1uR2Rv-SYmGCE5kgBgXodq7" > azure-creds.txt

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY ./public ./public
COPY ./src ./src

# build app for production with minification
RUN npm run build

EXPOSE 8080
CMD [ "http-server", "dist" ]
