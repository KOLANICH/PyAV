from __future__ import absolute_import

from .fifo cimport AudioFifo
from .frame cimport AudioFrame
from .resampler cimport AudioResampler
from ..codec.context cimport CodecContext


cdef class AudioCodecContext(CodecContext):

    # Hold onto the frames that we will decode until we have a full one.
    cdef AudioFrame next_frame

    # For encoding.
    cdef AudioResampler resampler
    cdef AudioFifo fifo
