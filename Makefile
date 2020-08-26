all: k3d elf pro-graf jenkins

all2: elf pro-graf jenkins

k3d:
	k3d cluster create labs \
	    -p 80:80@loadbalancer \
	    -p 443:443@loadbalancer \
	    -p 30000-32767:30000-32767@server[0] \
	    -v /etc/machine-id:/etc/machine-id:ro \
	    -v /var/log/journal:/var/log/journal:ro \
	    -v /var/run/docker.sock:/var/run/docker.sock \
	    --agents 3

jenkins:
	git clone https://github.com/KnowledgeHut-AWS/k8s-jenkins
	cd k8s-jenkins && ./jenkins.sh

elf:
	git clone https://github.com/KnowledgeHut-AWS/elf
	cd elf && ./elf.sh

pro-graf:
	git clone https://github.com/KnowledgeHut-AWS/pro-graf
	cd pro-graf && ./pro-graf.sh
