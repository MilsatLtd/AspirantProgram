from django.contrib import admin
from django import forms

# Register your models here.
from .models import *

# # add custom ui for admin to add cohort using api views
# from django.views.generic import TemplateView
# class CohortAdminView(TemplateView):
#     template_name = "admin/cohort_admin.html"

#     def get_context_data(self, **kwargs):
#         context = super().get_context_data(**kwargs)
#         context['cohort'] = Cohort.objects.all()
#         return context

class CohortAdminForm(forms.ModelForm):
    tracks = forms.ModelMultipleChoiceField(
        #  fetch tracks that are only related to the cohort while viewing the cohort
        queryset=Track.objects.all(),
        widget=forms.CheckboxSelectMultiple,
        required=False
    )

    class Meta:
        model = Cohort
        fields = '__all__'
        

class CohortAdmin(admin.ModelAdmin):
    # add list display of tracks related to this cohort
    list_filter = ('tracks',)


admin.site.register(User)
admin.site.register(Cohort, CohortAdmin)
admin.site.register(Students)
admin.site.register(Mentors)
admin.site.register(Track)
admin.site.register(Applications)