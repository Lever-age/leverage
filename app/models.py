from __future__ import unicode_literals

from django.db import models
from data import cleaner


class CampaignFinance(models.Model):
    FilerName = models.CharField(max_length=140)
    Year = models.CharField(max_length=140)
    Cycle = models.CharField(max_length=140)
    DocType = models.CharField(max_length=140)
    EntityName = models.CharField(max_length=140)
    EntityAddressLine1 = models.CharField(max_length=140)
    EntityAddressLine2 = models.CharField(max_length=140)
    EntityCity = models.CharField(max_length=140)
    EntityState = models.CharField(max_length=140)
    EntityZip = models.CharField(max_length=140)
    Occupation = models.CharField(max_length=140)
    EmployerName = models.CharField(max_length=140)
    EmployerAddressLine1 = models.CharField(max_length=140)
    EmployerAddressLine2 = models.CharField(max_length=140)
    EmployerCity = models.CharField(max_length=140)
    EmployerState = models.CharField(max_length=140)
    EmployerZip = models.CharField(max_length=140)
    Date = models.DateField()
    Amount = models.CharField(max_length=140)
    Description = models.CharField(max_length=140)
    Amended = models.CharField(max_length=140)
    SubDate = models.DateField()
    FiledBy = models.CharField(max_length=140)

    class Meta:
        ordering = ['SubDate']

    def __unicode__(self):
        return self.text

'''
class TopDoners(models.Model):
    topcontrib = cleaner.group_top100()
    print topcontrib.top100
'''