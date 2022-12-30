# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx
# port mapping instruction for aws elastic beanstalk
EXPOSE 80
# copy the /app/build from the output of the 'builder' phase above into nginx's default path for the static web(see nginx documentation: https://hub.docker.com/_/nginx)
COPY --from=builder /app/build /usr/share/nginx/html
# by default nginx provides the startup command, so specifying startup command(i.e. CMD [...]) here is not necessary.
