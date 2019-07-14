FROM elixir:1.8.1

MAINTAINER Edward Zhou

RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /app

ADD . /app

RUN mix deps.get
