# gateway/Dockerfile
FROM node:16-alpine

WORKDIR /app

COPY packages/gateway/package*.json ./
RUN npm install

COPY packages/gateway/* ./

EXPOSE 4000

CMD ["npx", "ts-node", "index.ts"]
# CMD ["tail", "-f", "/dev/null"]