# as builder - Vi setter navn på denne BUILD phasen
FROM node:16-alpine as builder

WORKDIR /usr/app
COPY package.json .
RUN npm install
COPY . .
# kjører run build, og mappen ligger i /usr/app/build
RUN npm run build

# En phase kan ha EN from. Så en NY FROM, betyr NY blokk
FROM nginx
# 1. --from=builder        - Vi vil kopiere mappe fra "builder" phase (se oppe)
# 2. /app/build            - Vi gir path til hva vi vil kopiere 
# 3. /usr/share/nginx/html -  Vi definerer hvor vi vil lime det inn 
#     NOTE: Path fant vi i nginx dockerhub documentasjon
# MERK: Er samme struktur som COPY over, bare at vi har et argument først..
COPY --from=builder /usr/app/build /usr/share/nginx/html