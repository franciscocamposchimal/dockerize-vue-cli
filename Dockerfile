# develop stage
FROM node:12.16-alpine as develop-stage
WORKDIR /app
RUN yarn global add @vue/cli
# build stage
FROM develop-stage as build-stage
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build
# production stage
FROM nginx:1.15.7-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]