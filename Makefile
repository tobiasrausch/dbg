SHELL := /bin/bash

# Targets
TARGETS = .conda .channels .awscli .oc .kubectl
PBASE=$(shell pwd)

all:  	$(TARGETS)

.conda:
	wget 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh' && bash Miniconda3-latest-Linux-x86_64.sh -b -p ${PBASE}/bin && rm -f Miniconda3-latest-Linux-x86_64.sh && touch .conda

.channels: .conda
	export PATH=${PBASE}/bin/bin:${PATH} && conda config --add channels defaults && conda config --add channels conda-forge && conda config --add channels bioconda && touch .channels

.awscli: .conda .channels
	export PATH=${PBASE}/bin/bin:${PATH} &&	pip install awscli && touch .awscli

.oc:
	mkdir -p bin && cd bin/ && wget 'https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/linux/oc.tar.gz' && tar -xzf oc.tar.gz && rm oc.tar.gz && cd .. && touch .oc

.kubectl:
	mkdir -p bin && cd bin/ && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.0/bin/linux/amd64/kubectl && chmod +x ./kubectl && cd .. && touch .kubectl

version:
	export PATH=${PBASE}/bin/bin:${PATH} && echo "awscli" && aws --version && echo "kubectl" && ./bin/kubectl version && echo "oc" && ./bin/oc version

clean:
	echo "Nothing to be cleaned"

distclean:
	rm -rf $(TARGETS) $(TARGETS:=.o) bin/

.PHONY: distclean clean all
