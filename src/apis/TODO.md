<!-- Todo Tasks -->
- [x] Send email using a task scheduler like celery and redis
- [x] Add UI for monitoring celery tasks (e.g flower)
- [ ] Add date created for each model and use that when ordering (e.g courses).
- [ ] Create a function/class to return a reusable error json to report errors / success messages. Ensure its used thoughout the project for all endpoints.
- [ ] Rearrange the project structure to be more modular and scalable. (e.g serializer, urls, models, views should be split for each model)
- [ ] Remove the need for unnecessary repetitive queries in the serializers and services. (e.g different classes for fetching latest track.) All related endpoint should fetch all the necessary data in one query or as few as possible based on their latest cohort/track unless stated otherwise.
- [ ] Admin should be able to view the progress of each student in a cohort and select who should receive a certificate.
- [ ] Admin should be able to remove or disable a student from a cohort when not active.
- [ ] Make use of websockets for all things communication. (e.g chat in blockers/comments).
