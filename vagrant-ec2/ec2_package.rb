#!/usr/bin/env ruby
#Make a tarball of only the recipes called in dna.json
#Takes as an argument the path to a Vagrant VM's folder.
require 'rubygems'
require 'json'

Dir.chdir(ARGV[0]) do
  #run vagrant to parse the `Vagrantfile` and write out `dna.json` and `.cookbooks_path.json`.
  res = `vagrant`
  if $?.exitstatus != 0
    puts res
    exit 1
  end
  CookbooksPath = [JSON.parse(open('cookbooks_path.json').read)].flatten

  recipe_names = []
  JSON.parse(open('dna.json').read)["run_list"].each do |x|
    recipe_names.push(x.gsub('recipe', '').gsub(/(\[|\])/, '').gsub(/::.*$/, '')) if x.index('recipe')
  end
  recipe_names = recipe_names.uniq

  open('tar_list', 'w'){|f|
    f.puts recipe_names.map{|x|
      
      paths = CookbooksPath.map{|path|
        "../#{path}/#{x}"
      }
      paths.reject!{|path| not File.exists?(path)}
      raise "Multiple cookbooks '#{x}' exist within `chef.cookbooks_path`; I'm not sure which one to use" if paths.length > 1
      raise "I can't find any cookbooks called '#{x}'" if paths.length == 0
      
      paths[0]
    }
  }

  RolesPath = [JSON.parse(open('roles_path.json').read)].flatten

  role_names = []
  JSON.parse(open('dna.json').read)["run_list"].each do |x|
    role_names.push(x.gsub('role', '').gsub(/(\[|\])/, '').gsub(/::.*$/, '') + '.rb') if x.index('role')
  end
  role_names = role_names.uniq
  
  open('tar_list', 'a'){|f|
    f.puts role_names.map{|x|
      
      paths = RolesPath.map{|path|
        "../#{path}/#{x}"
      }
      paths.reject!{|path| not File.exists?(path)}
      raise "Multiple roles '#{x}' exist within `chef.roles_path`; I'm not sure which one to use" if paths.length > 1
      raise "I can't find any roles called '#{x}'" if paths.length == 0
      
      paths[0]
    }
  }


  #Have tar chop off all of the relative file business prefixes so we can just
  #upload everything to the same cookbooks directory
  #transforms = CookbooksPath.map{|path| "--transform=s,^#{path.gsub(/^\//, '')},cookbooks, "}
  #`tar czf cookbooks.tgz --files-from recipe_list #{transforms*' '} 2> /dev/null`
  `tar czf cookbooks.tgz --files-from tar_list 2> /dev/null`
  `rm tar_list`
end
