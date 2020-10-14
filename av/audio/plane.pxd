from __future__ import absolute_import
from ..plane cimport Plane


cdef class AudioPlane(Plane):

    cdef readonly size_t buffer_size

    cdef size_t _buffer_size(self)
