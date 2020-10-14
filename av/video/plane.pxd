from __future__ import absolute_import
from ..plane cimport Plane
from .format cimport VideoFormatComponent


cdef class VideoPlane(Plane):

    cdef readonly size_t buffer_size
    cdef readonly unsigned int width, height
