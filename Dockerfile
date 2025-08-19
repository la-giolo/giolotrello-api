ARG ELIXIR_VERSION=1.17.3
ARG OTP_VERSION=27.3
ARG ALPINE_VERSION=3.20.6

ARG IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-alpine-${ALPINE_VERSION}"

FROM ${IMAGE}

RUN apk add --no-cache build-base git ca-certificates openssl curl

# Force IPv4 for hex/rebar
ENV HEX_CDN=fastly
ENV HEX_UNSAFE_HTTPS=1
ENV REBAR_GLOBAL_HEX_OPTS="--ipv4"
ENV HEX_HTTP_CONCURRENCY=1

WORKDIR /app
COPY mix.exs mix.lock ./
RUN mix local.hex --force && mix local.rebar --force && mix deps.get

COPY . .
EXPOSE 4000
CMD ["mix", "phx.server"]
