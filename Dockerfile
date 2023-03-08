FROM node:latest

WORKDIR /app
COPY . .

RUN npm install --registry=https://registry.npm.taobao.org

EXPOSE 9527

CMD ["npm", "run", "dev"]
