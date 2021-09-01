FROM node:10.15.2

WORKDIR /usr/src/app
COPY package*.json ./
COPY tsconfig.json ./
RUN npm install
COPY ./src ./src
RUN npm run build

FROM node:10.15.2-alpine

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY --from=0 /usr/src/app/build ./build
EXPOSE 80

ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT

CMD npm start
