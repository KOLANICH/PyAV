from __future__ import absolute_import
cimport libav as lib

from .graph cimport Graph
from .pad cimport FilterContextPad


cdef class FilterLink(object):

    cdef readonly Graph graph
    cdef lib.AVFilterLink *ptr

    cdef FilterContextPad _input
    cdef FilterContextPad _output


cdef FilterLink wrap_filter_link(Graph graph, lib.AVFilterLink *ptr)
