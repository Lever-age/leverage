from __future__ import unicode_literals

from django.db import models


class CampaignFinance(models.Model):
    FilerName = models.CharField(max_length=140)
    Year = models.CharField(max_length=140)
    Cycle = models.CharField(max_length=140)
    Amount = models.CharField(max_length=140)
    Description = models.CharField(max_length=140)
    Amended	= models.CharField(max_length=140)
    SubDate = models.DateField()
    FiledBy = models.CharField(max_length=140)

    class Meta:
        ordering = ['SubDate']

    def __unicode__(self):
        return self.text