from __future__ import absolute_import
from .buffer cimport Buffer
from .frame cimport Frame


cdef class Plane(Buffer):

    cdef Frame frame
    cdef int index

    cdef size_t _buffer_size(self)
    cdef void* _buffer_ptr(self)
