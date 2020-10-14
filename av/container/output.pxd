from __future__ import absolute_import
cimport libav as lib

from .core cimport Container
from ..stream cimport Stream


cdef class OutputContainer(Container):

    cdef bint _started
    cdef bint _done

    cpdef start_encoding(self)
