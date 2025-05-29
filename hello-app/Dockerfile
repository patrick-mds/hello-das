FROM node:20-alpine

WORKDIR /app

COPY package*.json .
RUN npm ci
COPY src/index.js index.js
EXPOSE 3000
CMD ["node", "index.js"]