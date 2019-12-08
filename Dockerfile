FROM elixir:latest
ARG app_name=wiki_charts
ARG build_env=prod
ENV MIX_ENV=${build_env} TERM=xterm
WORKDIR /app
RUN mix local.rebar --force && mix local.hex --force
COPY . .
RUN mix do deps.get, compile
RUN mix distillery.release --env=${build_env} --executable --verbose \
    && mv _build/${build_env}/rel/${app_name}/bin/${app_name}.run start_release