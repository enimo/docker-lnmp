# FROM node:6
# FROM node:6-alpine
FROM node:14.17-alpine3.14

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

ENV PATH=$PATH:/home/node/.npm-global/bin 
# optionally if you want to run npm global bin without specifying path

ENV YARN_VERSION 1.16.0

RUN apk add --no-cache --virtual .build-deps-yarn curl \
    && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
    && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
    && ln -snf /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
    && rm yarn-v$YARN_VERSION.tar.gz \
    && apk del .build-deps-yarn


# Here is an example of how you would install dependencies for packages that require node-gyp support on the alpine variant:
# RUN apk add --no-cache --virtual .gyp python make g++ \
#     && npm install [ your npm dependencies here ] \
#     && apk del .gyp


# RUN yarn global add forever

RUN mkdir /srv/app && chown 1000:1000 -R /srv/app

WORKDIR /srv/app
# COPY ./strapi/package.json ./
# COPY ./strapi/yarn.lock ./

VOLUME /srv/app


RUN npm install --global http-server

# RUN npm install

# COPY . .

# ENV NODE_ENV production

# RUN npm build

# EXPOSE 1337


# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]

# CMD ["npm", "start"]
CMD ["http-server", "./ --port 9101"]

