#expressjs #javascript #typescript #web #rhel #rhel8 #podman #docker #container-engine #containerization 
#debian #ubuntu #debian13 #nodejs20 
# Node.js runtime
## Red Hat-based image
- The standard location for source code on Red Hat based image is `/opt/app-root/src`.
- The standard location for binary executable file on Red hat based image is `/opt/app-root/bin`.
### Red Hat 8
```Dockerfile title='Containerfile to build an express.js app with Red Hat Universal Binary Image 8'

WORKDIR /opt/app-root/src

COPY package*.json yarn.lock ./

RUN npm install -g yarn && \
    yarn install --frozen-lockfile --verbose

COPY . .

RUN yarn build --verbose

# Runtime stage
FROM registry.redhat.io/ubi8/nodejs-20:latest

ENV NODE_ENV=production
ENV PAYLOAD_CONFIG_PATH=dist/payload.config.js

WORKDIR /opt/app-root/src

COPY package*.json yarn.lock ./

RUN npm install -g yarn && \
    yarn install --production --frozen-lockfile --verbose && \
    npm uninstall -g yarn

COPY --from=builder /opt/app-root/src/dist ./dist
COPY --from=builder /opt/app-root/src/build ./build

EXPOSE 3000

CMD ["node", "/opt/app-root/src/dist/server.js"]
```
## Debian-based image
- The default user and group configured for application runtime is `node:node`.
```Dockerfile title='Containerfile to build an express.js app with Debian 13 image'
FROM docker.io/library/node:20-trixie-slim AS builder

WORKDIR /app

COPY --chown=node:node package.json package-lock.json ./
RUN npm ci

COPY --chown=node:node . .

RUN npx prisma generate

RUN npx nx build api --production


FROM docker.io/library/node:20-trixie-slim AS runtime

RUN mkdir /app && chown -R node:node /app

USER node
WORKDIR /app

COPY --from=builder --chown=node:node /app/dist/api .
COPY --from=builder --chown=node:node /app/package.json .
COPY --from=builder --chown=node:node /app/package-lock.json .
COPY --from=builder --chown=node:node /app/src/prisma ./src/prisma

RUN npm install --production

ENV NODE_ENV=production

CMD [ "node", "main.js" ]

```
***
# References
1. https://docs.redhat.com/en/documentation/openshift_online/3/html-single/architecture/index#architecture-core-concepts-containers-and-images for Red Hat Universal Binary Image.
2. [[operating-system/unix/linux/system-administration/access-control/User|User]] for User in Linux.
3. [[operating-system/unix/linux/system-administration/access-control/File permissions|File permissions]] for File permissions in Linux.
4. [[operating-system/unix/linux/system-administration/access-control/Group|Group]] for Group in Linux.