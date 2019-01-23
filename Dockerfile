FROM debian:9-slim

LABEL \
	maintainer="shiuan.dsc@gmail.com" \
	description="Terraria TShock Server"
	
ENV VERSION=4.3.25

# Install packages
RUN apt-get update \
	&& apt-get install -y --no-install-recommends wget unzip mono-complete \
	&& rm -rf /var/lib/apt/lists/*

# Download tshock, unzip, create terraria user
RUN wget -q "https://github.com/Pryaxis/TShock/releases/download/v$VERSION/tshock_$VERSION.zip" -O /tmp/tshock.zip \
	&& useradd -m terraria \
	&& mkdir -p /home/terraria/tshock /terraria \
	&& cd /home/terraria/tshock \
	&& unzip /tmp/tshock.zip \
	&& chown -R terraria:terraria /home/terraria /terraria \
	&& chmod -R 775 /home/terraria /terraria

COPY --chown=terraria:terraria ["entrypoint.sh", "/home/terraria/"]

USER terraria
WORKDIR ["/home/terraria"]

ENTRYPOINT ["/home/terraria/entrypoint.sh"]