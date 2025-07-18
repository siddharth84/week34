FROM node:20

WORKDIR /app

COPY package*.json ./
COPY ./package-lock.json ./package-lock.json
RUN npm install

COPY . .

ENV DATABASE_URL=postgresql://postgres:mysecretpassword@localhost:5432/postgres
RUN echo $DATABASE_URL

#RUN DATABASE_URL=${DATABASE_URL} npx prisma migrate dev
#RUN npx prisma generate
RUN npm run build

EXPOSE 3000

#CMD [ "npm", "start" ]
CMD npx prisma generate && npx prisma migrate deploy && npm start