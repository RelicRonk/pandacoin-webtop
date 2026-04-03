Pandacoin Webtop is a browser based linux os running pandacoin utilizing the webtop interface.

In the coming days we will be compiling a guide on how to deploy this on your local machine. 


Getting Started
with a fresh vps, for debian or ubuntu first you want

	apt update && apt upgrade
	
	curl -fsSL https://get.docker.com -o get-docker.sh
	
	sh get-docker.sh
	
	adduser Username
	
	usermod -aG docker Username
	
	su Username
	
	cd ~
	
	git clone https://github.com/RelicRonk/pandacoin-webtop

After you clone the repo and have docker installed, navigate to the pandacoin-webtop directory and execute the following commands.

Build The docker
	
	docker build -t pndwebtop .

	docker run -d  --name=pndwebtop-container /
	-e PASSWORD=CHANGEME / 
	-e PUID=0 / 
	-e PGID=0 /  
	-e TZ=Etc/UTC /   
	-p 3000:3000 /  
	-p 3001:3001 /  
	-v PATHTODOCKERFILE:/config /  
	--shm-size="3gb" /  
	--restart unless-stopped /  
	pndwebtop

your PUID and PGID must match your users info that starts the docker, to get this info type "id"

once you start the project it can be accessed via https://HOST:3001

Username: abc
Password: set at the -e PASSWORD= line
