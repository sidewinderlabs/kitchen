name "elasticsearch"
description "ElasticSearch Server"
run_list(
  "role[base]",
  "recipe[misc::elasticsearch]"
)
