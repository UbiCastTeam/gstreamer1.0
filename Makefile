build_debs:
	docker run -v $$PWD:/work/gst -w /work/gst registry.ubicast.net/public-projects/gstreamer1.0:$(shell git branch --show-current | tr '.+' '-') /bin/bash -c "	\
		export GI_SCANNER_DISABLE_CACHE=1;                                          \
		mk-build-deps -irt 'apt-get --no-install-recommends -yV' debian/control &&  \
		debuild -i -us -uc -b &&                                                    \
		mkdir -p debs &&                                                            \
		mv ../*.deb debs                                                            \
		"
