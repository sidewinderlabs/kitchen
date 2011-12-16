name "data"
description "Data Server"
run_list(
  "recipe[misc::solr]",
  "recipe[misc::data-api]"
)
