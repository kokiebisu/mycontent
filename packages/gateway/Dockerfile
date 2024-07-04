FROM node:16-alpine as Builder
WORKDIR /app
COPY packages/gateway/*.json ./
RUN npm install
COPY packages/gateway/src ./src
RUN npm run build

FROM node:16-alpine
COPY --from=Builder /app/dist /app/dist
COPY --from=Builder /app/package*.json ./
RUN npm install --only=production
EXPOSE 4000

CMD ["node", "/app/dist/index.js"]
