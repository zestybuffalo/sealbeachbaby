# Base Image Setup
FROM node:9-alpine

#create app directory
RUN mkdir -p /src/app

#copy package.json to app dir
COPY package.json /src/app/package.json

#install packages
RUN npm install

#copy rest of source code
COPY . /src/app 

#expose the port
EXPOSE 3000

#command to start the app
CMD ["npm","start"]
