FROM node:10-alpine

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT ${SOURCE_COMMIT}
ARG DOCKER_TAG
ENV DOCKER_TAG ${DOCKER_TAG}

ENV NPM_CONFIG_LOGLEVEL warn

RUN apk add --no-cache git nano

RUN npm config set unsafe-perm true
RUN npm i npm@latest -g
RUN npm install -g yarn

WORKDIR /var/app
RUN mkdir -p /var/app


COPY package.json /var/app/
RUN npm install

COPY . /var/app
RUN node cli/update-exchangerates.js

RUN node cli/update-steem-per-mvests.js

ENV PORT 3000

EXPOSE 3000

#ENTRYPOINT ["echo","node get-claimed-rewards.js username"]
#CMD ["/bin/sh"]

# uncomment the lines below to run it in development mode
# ENV NODE_ENV development
# CMD [ "yarn", "run", "start" ]
