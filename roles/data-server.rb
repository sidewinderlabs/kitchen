name "data"
description "Data Server"
run_list(
  "recipe[misc::elasticsearch]",
  "recipe[misc::data-api]"
)
