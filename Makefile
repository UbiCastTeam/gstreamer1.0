ifneq (${SSH_AUTH_SOCK},)
SSH_AGENT_PARAM := \
        -v $(shell dirname ${SSH_AUTH_SOCK}):$(shell dirname ${SSH_AUTH_SOCK}) \
        -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK}
else
SSH_AGENT_PARAM :=
endif

CONTAINER_IMAGE := registry.ubicast.net/public-projects/gstreamer1.0:trixie

build_debs:
	podman image pull $(CONTAINER_IMAGE)
	podman container run -v ${CURDIR}:/work/gst -w /work/gst \
		${SSH_AGENT_PARAM} $(CONTAINER_IMAGE) /bin/bash -c " \
		export GI_SCANNER_DISABLE_CACHE=1; \
		sed -i -Ee '\$$a\StrictHostKeyChecking accept-new' /etc/ssh/ssh_config && \
		mk-build-deps -irt 'apt-get --no-install-recommends -yV' debian/control && \
		debuild -e SSH_AUTH_SOCK -i -us -uc -b && \
		mkdir -p debs && \
		mv ../*.deb debs \
		"
