FROM node:alpine as build-stage
WORKDIR /src
COPY . /src
RUN npm install && npm run build

FROM node:alpine
WORKDIR /src
COPY --from=build-stage /src/dist ./dist
RUN npm install -g serve
RUN chown -R node /src
USER node
EXPOSE 5000
ENTRYPOINT serve -s -l 5000 dist