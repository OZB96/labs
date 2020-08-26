deploy: elf pro-graf jenkins

up: cluster deploy

cluster:
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
	rm -rf k8s-jenkins

jenkins-down:
	helm -n jenkins uninstall jenkins

elf:
	git clone https://github.com/KnowledgeHut-AWS/elf
	cd elf && ./elf.sh
	rm -rf elf

elf-down:
	helm uninstall elasticsearch --namespace=elf
	helm uninstall fluent-bit --namespace=elf
	helm uninstall kibana elastic/kibana --namespace=elf
	kubectl delete random-logger -n elf

pro-graf:
	git clone https://github.com/KnowledgeHut-AWS/pro-graf
	cd pro-graf && ./pro-graf.sh
	rm -rf pro-graf

pro-graf-down:
	helm uninstall prometheus-operator -n monitor
