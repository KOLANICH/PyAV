from __future__ import absolute_import
cimport libav as lib

from ..error cimport err_check
from ..frame cimport Frame
from ..packet cimport Packet
from .subtitle cimport SubtitleProxy, SubtitleSet


cdef class SubtitleCodecContext(CodecContext):

    cdef _send_packet_and_recv(self, Packet packet):
        cdef SubtitleProxy proxy = SubtitleProxy()

        cdef int got_frame = 0
        err_check(lib.avcodec_decode_subtitle2(
            self.ptr,
            &proxy.struct,
            &got_frame,
            &packet.struct if packet else NULL))
        if got_frame:
            return [SubtitleSet(proxy)]
        else:
            return []
