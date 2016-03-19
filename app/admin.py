from django.contrib import admin

# Register your models here.

from app.models import CampaignFinance


class CampaignFinanceAdmin(admin.ModelAdmin):
    pass

admin.site.register(CampaignFinance, CampaignFinanceAdmin)

