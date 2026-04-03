Pandacoin Webtop is a browser based linux os running pandacoin utilizing the webtop interface.

In the coming days we will be compiling a guide on how to deploy this on your local machine. 


Getting Started
with a fresh vps, for debian or ubuntu first you want to update and install packages.


update the source list and upgrade the everything.
	
	apt update && apt upgrade
	
	
Then you want to download the docker install file and execute it. 
	
	curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh

Next you want to create a user and add it to the docker group.
	
	adduser Username
	usermod -aG docker Username

Now you can take control of that user with the following.	
	
	su Username && cd ~
		
Clone the pandacoin webtop github repo.
	
	git clone https://github.com/RelicRonk/pandacoin-webtop

After you clone the repo and have docker installed, navigate to the pandacoin-webtop directory and execute the following commands.

Build The docker
	
	docker build -t pndwebtop .

Use this command to start the docker.
	
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
		
to stop a docker container you first have to get the ID of the container using the following 
	
	docker ps -a

Then you would issue the stop command
	
	docker stop #ID

to remove the container to start a fresh build you would
	
	docker stop #ID
		
to remove a docker built image first find the image id with the following
	
	docker images
		
then you would issue the following to delete the docker image..
	
	docker rmi #ID

your PUID and PGID must match your users info that starts the docker, to get this info type "id"

once you start the project it can be accessed via https://HOST:3001

Username: abc
Password: set at the -e PASSWORD= line
