FROM node:24-bookworm-slim

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends unzip ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY underlamp-source.zip /tmp/underlamp-source.zip
RUN unzip -q /tmp/underlamp-source.zip -d /app \
  && rm /tmp/underlamp-source.zip

RUN npm install -g pnpm@11.28.5
RUN pnpm install --frozen-lockfile && pnpm build

ENV NODE_ENV=production
ENV PORT=8787
EXPOSE 8787

CMD ["node", "server/index.js"]
