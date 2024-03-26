FROM node:18-alpine AS builder

WORKDIR /app

COPY ./package*.json ./

RUN npm install

COPY . .

RUN npm run

RUN npm run build

FROM nginx AS runner

EXPOSE 5173

COPY --from=builder /app/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]