FROM node:10.16.0-alpine

ENV PORT=8080 \
    APP_DIR=/app/src

ARG PROXY_ADDR=

WORKDIR ${APP_DIR}

COPY package*.json index.js ./

RUN chown -R node:node ${APP_DIR}

USER node

WORKDIR ${APP_DIR}

RUN if [ -n "${PROXY_ADDR}" ]; then \
        yarn config set proxy ${PROXY_ADDR} ; \
        fi \
	&& yarn install --production=true

EXPOSE ${PORT}

CMD ["yarn","start"]
