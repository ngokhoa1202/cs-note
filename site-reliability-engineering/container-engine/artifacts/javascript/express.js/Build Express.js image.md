#expressjs #javascript #typescript #web #rhel #rhel8 #podman #docker 
# Node.js runtime
## Red Hat
- The standard location for source code on Red Hat based image is `/opt/app-root/src`.
- The standard location for binary executable file on Red hat based image is `/opt/app-root/bin`.
## Red Hat 8
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
***
# References
1. https://docs.redhat.com/en/documentation/openshift_online/3/html-single/architecture/index#architecture-core-concepts-containers-and-images for Red Hat Universal Binary Image.