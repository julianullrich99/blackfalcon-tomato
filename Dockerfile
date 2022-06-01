FROM node:16-alpine AS builder

WORKDIR /app

RUN wget -qO- https://get.pnpm.io/v6.16.js | node - add --global pnpm

# fetch dependencies
COPY package.json .
COPY pnpm-lock.yaml .
RUN pnpm i --frozen-lockfile

COPY . .

# build
RUN pnpm build

###########################################################################################################################################

FROM harbor.falcondev.de/falcondev/nginx:latest AS runner

COPY --from=builder /app/dist /html

RUN nginx