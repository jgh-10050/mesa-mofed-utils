# Copyright (c) 2023 Hewlett Packard Enterprise Development LP

GIT_USERNAME ?= 
REGISTRY ?= ghcr.io
PUSH ?= false

MOFED_PROD_VERSION ?= 5.9-0.5.6.0
OFED_PROD_VERSION=0.0.1
MOFED_IMGNAME=mesa-mofed-utils
OFED_IMGNAME=mesa-ofed-utils
MOFED_IMGPATH=$(REGISTRY)/$(GIT_USERNAME)/$(MOFED_IMGNAME)
OFED_IMGPATH=$(REGISTRY)/$(GIT_USERNAME)/$(OFED_IMGNAME)

all: image-mofed
mofed: image-mofed
ofed: image-ofed
clean: clean-mofed clean-ofed

ifndef GIT_USERNAME
  $(error GIT_USERNAME is undefined)
endif

image-mofed:
	docker build -f Dockerfile --label $(MOFED_IMGPATH):$(MOFED_PROD_VERSION) \
        --build-arg MOFED_VER=$(MOFED_PROD_VERSION) -t $(MOFED_IMGPATH):$(MOFED_PROD_VERSION) .
	@if [ $(PUSH) = "true" ]; then \
		echo pushing $(MOFED_IMGPATH):$(MOFED_PROD_VERSION); \
		docker push $(MOFED_IMGPATH):$(MOFED_PROD_VERSION); fi

image-ofed:
	docker build -f Dockerfile-ofed --label $(OFED_IMGPATH):$(OFED_PROD_VERSION) -t $(OFED_IMGPATH):$(OFED_PROD_VERSION) .
	@if [ $(PUSH) = "true" ]; then \
		echo pushing $(OFED_IMGPATH):$(OFED_PROD_VERSION); \
		docker push $(OFED_IMGPATH):$(OFED_PROD_VERSION); fi

clean-mofed:
	docker rmi $(MOFED_IMGPATH):$(MOFED_PROD_VERSION)

clean-ofed:
	docker rmi $(OFED_IMGPATH):$(OFED_PROD_VERSION)
