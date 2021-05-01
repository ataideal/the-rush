FROM node:lts-alpine

ENV APP_HOME /the_rush_frontend
RUN mkdir $APP_HOME
ADD . $APP_HOME
WORKDIR $APP_HOME

CMD ["docker/entrypoint.sh"]
