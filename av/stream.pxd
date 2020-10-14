from __future__ import absolute_import
from libc.stdint cimport int64_t
cimport libav as lib

from .codec.context cimport CodecContext
from .container.core cimport Container
from .frame cimport Frame
from .packet cimport Packet


cdef class Stream(object):

    # Stream attributes.
    cdef readonly Container container

    cdef lib.AVStream *_stream
    cdef readonly dict metadata

    # CodecContext attributes.
    cdef lib.AVCodecContext *_codec_context
    cdef const lib.AVCodec *_codec

    cdef readonly CodecContext codec_context

    # Private API.
    cdef _init(self, Container, lib.AVStream*)
    cdef _finalize_for_output(self)


cdef Stream wrap_stream(Container, lib.AVStream*)
