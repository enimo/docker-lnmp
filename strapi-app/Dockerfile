#############
# 1、DEV开发版-每次容器启动都重新npm install
# 可配置数据库相关的信息
#############

FROM strapi/base 

RUN yarn global add strapi@3.6.6

RUN mkdir /srv/app && chown 1000:1000 -R /srv/app

WORKDIR /srv/app

RUN DOCKER=true strapi new . \
      --dbclient=mysql \
      --dbhost=mysql8 \
      --dbport=3306 \
      --dbname=db \
      --dbusername=user \
      --dbpassword=pass \
      --dbssl=$DATABASE_SSL \
      $EXTRA_ARGS \

VOLUME /srv/app/config

# COPY docker-entrypoint.sh /usr/local/bin/
# ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["strapi", "develop"]
# CMD ["strapi", "start"]






#############
# 2、BUILD 线上版, 直接容器启动即可启动npm start
# 数据库配置已在构建容器时指定，可在strapi/conf下更改
#############

# FROM strapi/base

# WORKDIR /srv/app

# COPY ./strapi/package.json ./
# COPY ./strapi/yarn.lock ./

# RUN yarn install

# COPY . .

# ENV NODE_ENV production

# RUN yarn build

# VOLUME /srv/app/config

# EXPOSE 1337

# CMD ["yarn", "start"]

