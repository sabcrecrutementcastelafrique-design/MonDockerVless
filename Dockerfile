FROM alpine:latest

# Installation des outils réseau de base
RUN apk add --no-cache curl wget unzip iptables socat

WORKDIR /app

# Téléchargement et installation du noyau Xray (utilisé pour le protocole VLess)
RUN wget -O xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && \
    rm xray.zip

# Copie du fichier de configuration interne
COPY config.json /app/config.json

# Cloud Run exige d'écouter sur le port 8080
EXPOSE 8080

# Lancement du serveur Xray
CMD ["./xray", "-config", "config.json"]
