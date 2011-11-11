Overview
========

This project contains everything needed to build, test and deploy Sidewinder Labs applications.

Vagrant
=======

First, [install Chef, VirtualBox and Vagrant](chef-repo/wiki).

To launch a VM that contains a local Drupal server, navigate to the `vagrant` directory and run:

```
vagrant up ui_server
```

The first time this is run it will take some time, since Vagrant needs to download a base instance of Debian (what they call a 'box'). Once this has been downloaded it will be kept for future use when building new VMs.

Once the entire process has completed, it will be possible to connect to the VM using SSH. To do this use the Vagrant `ssh` command:

```
vagrant ssh ui_server
```
  
To connect to the web-site that was created use the following IP address and port number:

```
33.33.33.10:8888
```

The VM can be suspended using:

```
vagrant suspend ui_server
```

See the [Vagrant commands](http://vagrantup.com/docs/commands.html) reference for more on what you can do with the VM.

Database interaction
====================

The live scripts are configured to get the Drupal instances talking to an RDS database. For development purposes we'll probably want to create our own local copies of the database, but to get this running quickly I've taken a snapshot of the live database, deployed it on a new RDS instance, and then updated the Vagrant scripts to set Drupal to point to this database. It has the advantage that any database changes you make whilst developing will not affect the live site, but it's still not ideal -- the solution is to factor out the database creation code that I have in the Chef scripts to separate scripts that can be run when appropriate.

Deploying different versions of the code
========================================

If you're not familiar with Chef's layout, the key things you'll probably want to change whilst developing are the revisions to be used when obtaining code from GitHub (defined in `site-cookbooks/misc/attributes/default.rb`), and the actual repos to use so that you can refer to your own forks (defined in `site-cookbooks/misc/recipes/default.rb`). The latter will be parameterised at some point soon, by having an entry in the `attributes` settings.

If you update either of these files to point to one of your code branches, you can get Vagrant to re-run the whole Chef sequence by exiting your SSH session, and then running:

```
vagrant provision ui_server
```

or:

```
vagrant reload ui_server
```

See the [Vagrant commands](http://vagrantup.com/docs/commands.html) reference for the difference between these two commands.

Chef Repositories
=================

Every Chef installation needs a Chef Repository. This is the place where cookbooks, roles, config files and other artifacts for managing systems with Chef will live. We strongly recommend storing this repository in a version control system such as Git and treat it like source code.

While we prefer Git, and make this repository available via GitHub, you are welcome to download a tar or zip archive and use your favorite version control system to manage the code.

Repository Directories
======================

This repository contains several directories, and each directory contains a README file that describes what it is for in greater detail, and how to use it for managing your systems with Chef.

* `certificates/` - SSL certificates generated by `rake ssl_cert` live here.
* `config/` - Contains the Rake configuration file, `rake.rb`.
* `cookbooks/` - Cookbooks you download or create.
* `data_bags/` - Store data bags and items in .json in the repository.
* `roles/` - Store roles in .rb or .json in the repository.

Rake Tasks
==========

The repository contains a `Rakefile` that includes tasks that are installed with the Chef libraries. To view the tasks available with in the repository with a brief description, run `rake -T`.

The default task (`default`) is run when executing `rake` with no arguments. It will call the task `test_cookbooks`.

The following tasks are not directly replaced by knife sub-commands.

* `bundle_cookbook[cookbook]` - Creates cookbook tarballs in the `pkgs/` dir.
* `install` - Calls `update`, `roles` and `upload_cookbooks` Rake tasks.
* `ssl_cert` - Create self-signed SSL certificates in `certificates/` dir.
* `update` - Update the repository from source control server, understands git and svn.

The following tasks duplicate functionality from knife and may be removed in a future version of Chef.

* `metadata` - replaced by `knife cookbook metadata -a`.
* `new_cookbook` - replaced by `knife cookbook create`.
* `role[role_name]` - replaced by `knife role from file`.
* `roles` - iterates over the roles and uploads with `knife role from file`.
* `test_cookbooks` - replaced by `knife cookbook test -a`.
* `test_cookbook[cookbook]` - replaced by `knife cookbook test COOKBOOK`.
* `upload_cookbooks` - replaced by `knife cookbook upload -a`.
* `upload_cookbook[cookbook]` - replaced by `knife cookbook upload COOKBOOK`.

Configuration
=============

The repository uses two configuration files.

* config/rake.rb
* .chef/knife.rb

The first, `config/rake.rb` configures the Rakefile in two sections.

* Constants used in the `ssl_cert` task for creating the certificates.
* Constants that set the directory locations used in various tasks.

If you use the `ssl_cert` task, change the values in the `config/rake.rb` file appropriately. These values were also used in the `new_cookbook` task, but that task is replaced by the `knife cookbook create` command which can be configured below.

The second config file, `.chef/knife.rb` is a repository specific configuration file for knife. If you're using the Opscode Platform, you can download one for your organization from the management console. If you're using the Open Source Chef Server, you can generate a new one with `knife configure`. For more information about configuring Knife, see the Knife documentation.

http://help.opscode.com/faqs/chefbasics/knife

Next Steps
==========

Read the README file in each of the subdirectories for more information about what goes in those directories.