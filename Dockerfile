FROM node:16-alpine AS builder

ENV NODE_ENV production
ENV NODE_ENV productionENV PORT 3000
WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx:1.21.5-alpine as production
COPY --from=builder /app/dist /usr/share/nginx/html
COPY /dockerize/nginx/nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]