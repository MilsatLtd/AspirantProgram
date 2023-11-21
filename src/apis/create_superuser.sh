#!/bin/bash
python3 manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(email='admin@milsat.tech').exists() or User.objects.create_superuser('admin@milsat.tech', first_name='map', last_name='admin', gender=0, country='Nigeria', phone_number='07039496535', bio='', password='Password123?_')"
