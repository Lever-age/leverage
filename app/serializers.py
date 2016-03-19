from django.contrib.auth.models import User, Group
from rest_framework import serializers
from app.models import CampaignFinance


class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'groups')


class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')


class CampaignFinanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = CampaignFinance
        fields = ('FilerName', 'Year', 'Cycle',	'DocType', 'EntityName', 'EntityAddressLine1', 'EntityAddressLine2',
                  'EntityCity', 'EntityState', 'EntityZip', 'Occupation', 'EmployerName', 'EmployerAddressLine1',
                  'EmployerAddressLine2', 'EmployerCity', 'EmployerState', 'EmployerZip', 'Date', 'Amount',
                  'Description', 'Amended', 'SubDate', 'FiledBy')