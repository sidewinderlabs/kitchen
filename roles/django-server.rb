name "django"
description "Django Server"
run_list(
  "recipe[misc::django-server]"
)
