# SHA-pinnattu base image
FROM node:22-slim@sha256:813a7480f28fdadac1f7f5c824bcdad435b5bc1322a5968bbbdef8d058f9dff4

# Luo uuden ryhmän ja käyttäjän ilman root-oikeuksia
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Asetetaan työhakemisto 
WORKDIR /app

# Kopioidaan riippuvuudet
COPY package*.json ./
RUN npm ci --only=production

# Kopioidaan sovelluksen lähdekoodi imageen
COPY . .

# Vaihdetaan käyttäjäksi aiemmin luotu appuser, ei root-oikeuksia
USER appuser

# Kuuntelee porttia 3000
EXPOSE 3000
# Käynnistyskomento, array-muoto on turvallisempi koska ei käytetä shelliä
CMD ["node", "index.js"]

