"""
Camera views
"""

from __future__ import absolute_import, unicode_literals

import logging

from django.http import JsonResponse
from filters.mixins import FiltersMixin
from rest_framework import filters, viewsets
from rest_framework.decorators import api_view

from configs.app_insight import APP_INSIGHT_INST_KEY

from ..models import Camera
from .serializers import CameraSerializer

logger = logging.getLogger(__name__)


# pylint: disable=too-many-ancestors
class CameraViewSet(FiltersMixin, viewsets.ModelViewSet):
    """
    Camera ModelViewSet

    Available filters:
    @is_demo
    """

    queryset = Camera.objects.all()
    serializer_class = CameraSerializer
    filter_backends = (filters.OrderingFilter,)
    filter_mappings = {
        "is_demo": "is_demo",
    }


@api_view()
def instrumentation_key(request):
    """App Insight Instrument Key"""
    return JsonResponse({"status": "ok", "key": APP_INSIGHT_INST_KEY})
