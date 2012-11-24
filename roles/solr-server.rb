name "solr"
description "Solr Server"
run_list(
  "role[base]",
  "recipe[misc::solr]"
)
