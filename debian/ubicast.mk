# This file aims to contains the UbiCast custom GStreamer configuration a meson
# options.

# global meson options
# `--wrap-mode=default` -> cause is is set to `nodownload` in debhelpers
# --prefer-static \
global_opts = \
  --default-library=static \
  --auto-features=disabled \
  --wrap-mode=default \
  -Dgst-full=enabled \
  -Dintrospection=enabled \
  -Dtools=enabled \
  -Dgpl=enabled \
  #

# Gstreamer options
core_opts = \
  -Dgstreamer:gobject-cast-checks=enabled \
  -Dgstreamer:check=enabled \
  -Dgstreamer:glib-asserts=enabled \
  -Dgstreamer:glib-checks=enabled \
  -Dgstreamer:extra-checks=enabled \
  #

validate_opts = \
  -Ddevtools=enabled \
  -Dgst-devtools:validate=enabled \
  #

ges_opts = \
  -Dges=enabled \
	-Dgst-editing-services:validate=enabled \
	-Dgst-editing-services:libpython-dir='/usr/lib64/libpython{py}.so'

python_opts = \
  -Dpython=enabled \
	-Dgst-python:libpython-dir=/usr/lib64/libpython{py}.so \
  #

base_opts = \
  -Dbase=enabled \
  -Dgst-plugins-base:audioconvert=enabled \
  -Dgst-plugins-base:audiomixer=enabled \
  -Dgst-plugins-base:audiorate=enabled \
  -Dgst-plugins-base:audioresample=enabled \
  -Dgst-plugins-base:audiotestsrc=enabled \
  -Dgst-plugins-base:compositor=enabled \
  -Dgst-plugins-base:encoding=enabled \
  -Dgst-plugins-base:gio=enabled \
  -Dgst-plugins-base:ogg=enabled \
  -Dgst-plugins-base:pbtypes=enabled \
  -Dgst-plugins-base:playback=enabled \
  -Dgst-plugins-base:typefind=enabled \
  -Dgst-plugins-base:videoconvertscale=enabled \
  -Dgst-plugins-base:videorate=enabled \
  -Dgst-plugins-base:videotestsrc=enabled \
  -Dgst-plugins-base:volume=enabled \
  -Dgst-plugins-base:opus=enabled \
  -Dgst-plugins-base:vorbis=enabled \
  #

bad_opts = \
  -Dbad=enabled \
  -Dgst-plugins-bad:audiofxbad=enabled \
  -Dgst-plugins-bad:autoconvert=enabled \
  -Dgst-plugins-bad:fdkaac=enabled \
  -Dgst-plugins-bad:id3tag=enabled \
  -Dgst-plugins-bad:interlace=enabled \
  -Dgst-plugins-bad:jpegformat=enabled \
  -Dgst-plugins-bad:mpegdemux=enabled \
  -Dgst-plugins-bad:mpegpsmux=enabled \
  -Dgst-plugins-bad:mpegtsdemux=enabled \
  -Dgst-plugins-bad:mpegtsmux=enabled \
  -Dgst-plugins-bad:mxf=enabled \
  -Dgst-plugins-bad:timecode=enabled \
  -Dgst-plugins-bad:transcode=enabled \
  -Dgst-plugins-bad:videofilters=enabled \
  -Dgst-plugins-bad:videoparsers=enabled \
  -Dgst-plugins-bad:openh264=enabled \
  -Dgst-plugins-bad:hls=enabled \
  -Dgst-plugins-bad:opus=enabled \
  -Dgst-plugins-bad:rtmp2=enabled \
  -Dgst-plugins-bad:codectimestamper=enabled \
  # \
  # -Dgst-plugins-bad:opencv=enabled \
  #

good_opts = \
  -Dgood=enabled \
  -Dgst-plugins-good:lame=enabled \
  -Dgst-plugins-good:soup=enabled \
  -Dgst-plugins-good:alpha=enabled \
  -Dgst-plugins-good:audioparsers=enabled \
  -Dgst-plugins-good:avi=enabled \
  -Dgst-plugins-good:debugutils=enabled \
  -Dgst-plugins-good:deinterlace=enabled \
  -Dgst-plugins-good:flv=enabled \
  -Dgst-plugins-good:id3demux=enabled \
  -Dgst-plugins-good:imagefreeze=enabled \
  -Dgst-plugins-good:interleave=enabled \
  -Dgst-plugins-good:isomp4=enabled \
  -Dgst-plugins-good:level=enabled \
  -Dgst-plugins-good:matroska=enabled \
  -Dgst-plugins-good:multifile=enabled \
  -Dgst-plugins-good:multipart=enabled \
  -Dgst-plugins-good:smpte=enabled \
  -Dgst-plugins-good:videobox=enabled \
  -Dgst-plugins-good:videocrop=enabled \
  -Dgst-plugins-good:videofilter=enabled \
  -Dgst-plugins-good:wavparse=enabled \
  -Dgst-plugins-good:vpx=enabled \
  -Dgst-plugins-good:jpeg=enabled \
  -Dgst-plugins-good:adaptivedemux2=enabled \
  #

json_glib_opts = \
  -Djson-glib:tests=false   \
  -Djson-glib:introspection=disabled \
  #

# only for tests
ffmpeg_opts = \
  -DFFmpeg:h264_decoder=enabled \
  -DFFmpeg:hevc_decoder=enabled\
  -DFFmpeg:wmv1_decoder=enabled \
  -DFFmpeg:wmv2_decoder=enabled \
  -DFFmpeg:vc1_decoder=enabled \
  -DFFmpeg:wmv3_decoder=enabled \
  -DFFmpeg:wmav1_decoder=enabled \
  -DFFmpeg:wmav2_decoder=enabled \
  -DFFmpeg:wmavoice_decoder=enabled \
  -DFFmpeg:h263_decoder=enabled \
  -DFFmpeg:h263_parser=enabled \
  -DFFmpeg:mpeg4_decoder=enabled \
  -DFFmpeg:mpeg4video_parser=enabled \
  -DFFmpeg:ac3_decoder=enabled \
  -DFFmpeg:ac3_parser=enabled \
  #

av_opts = \
  -Dlibav=enabled \
  #

fdk_aac_opts = \
  -Dfdk-aac:remove-date=true \
  #

ugly_opts = \
  -Dugly=enabled \
  -Dgst-plugins-ugly:x264=enabled \
  #

# INFO: Use `,` as separator between project names
extra_projects = "gst_change_detect,gst_motion_detector"


conf_flags += \
  $(global_opts) \
  $(base_opts) \
  # \
  $(core_opts) \
  $(json_glib_opts) \
  $(ffmpeg_opts) \
  $(good_opts) \
  $(bad_opts) \
  $(validate_opts) \
  $(av_opts) \
  $(fdk_aac_opts) \
  $(ugly_opts) \
  # All text after this will be discarded
  # $(ges_opts) \
  # $(python_opts) \
  # -Dcustom_subprojects=$(extra_projects) \
  #

$(info "final conf_flags: ${conf_flags}")
