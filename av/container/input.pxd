from __future__ import absolute_import
cimport libav as lib

from .core cimport Container
from ..stream cimport Stream


cdef class InputContainer(Container):

    cdef flush_buffers(self)
