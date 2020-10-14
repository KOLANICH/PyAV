from __future__ import absolute_import
cimport libav as lib

from .context cimport FilterContext
from .filter cimport Filter
from .link cimport FilterLink


cdef class FilterPad(object):

    cdef readonly Filter filter
    cdef readonly FilterContext context
    cdef readonly bint is_input
    cdef readonly int index

    cdef const lib.AVFilterPad *base_ptr


cdef class FilterContextPad(FilterPad):

    cdef FilterLink _link


cdef tuple alloc_filter_pads(Filter, const lib.AVFilterPad *ptr, bint is_input, FilterContext context=?)
