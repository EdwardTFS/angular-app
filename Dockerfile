FROM node:20-slim as build
RUN mkdir -p /app
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build
FROM nginx:stable-alpine-slim as serve
EXPOSE 80
#COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/angular-app/browser /usr/share/nginx/html
