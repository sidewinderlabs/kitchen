name "hadoop-client"
description "Hadoop Client"
run_list(
  "recipe[misc::nose]",
  "recipe[misc::libtiff]",
  "recipe[misc::s3cmd]",
  "recipe[misc::hive]",
  "recipe[misc::mrjob]"
)
