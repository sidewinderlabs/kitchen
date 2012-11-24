name "django"
description "Django Server"
run_list(
  "role[base]",
  "recipe[misc::django-server]"
)
