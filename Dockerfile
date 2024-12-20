# Stage 1: Build
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Stage 2: Production
FROM node:18-bullseye

WORKDIR /app

COPY --from=build /app .

RUN npm run prisma:generate

EXPOSE 8080

CMD ["sh", "-c", " npm run prisma:deploy && npm start"]
