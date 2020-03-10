FROM elixir:1.10.2 AS builder

RUN mkdir /build
WORKDIR /build
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

ENV MIX_ENV=prod

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix release

FROM builder AS app

RUN mkdir /app
WORKDIR /app
COPY --from=builder /build/_build .
CMD ["./prod/rel/match_api/bin/match_api", "start"]

