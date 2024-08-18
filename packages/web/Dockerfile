FROM node:20-alpine

ARG NEXT_PUBLIC_API_HOST

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN echo "NEXT_PUBLIC_API_HOST=${NEXT_PUBLIC_API_HOST}" >> .env.production

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
