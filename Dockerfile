FROM hexpm/elixir:1.17.2-erlang-27.0.1-alpine-3.20.3

RUN apk add --no-cache build-base git

WORKDIR /app
COPY mix.exs mix.lock ./
RUN mix local.hex --force && mix local.rebar --force && mix deps.get

COPY . .
CMD ["mix", "phx.server"]
