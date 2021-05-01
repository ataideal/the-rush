FROM elixir:1.11

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.8 --force && \
    mix local.rebar --force

ENV APP_HOME /the_rush_backend
RUN mkdir $APP_HOME
ADD . $APP_HOME
WORKDIR $APP_HOME

CMD ["docker/entrypoint.sh"]
