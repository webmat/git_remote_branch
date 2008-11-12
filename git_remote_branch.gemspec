--- !ruby/object:Gem::Specification 
name: git_remote_branch
version: !ruby/object:Gem::Version 
  version: 0.2.7
platform: ruby
authors: 
- Mathieu Martin
- Carl Mercier
autorequire: 
bindir: bin
cert_chain: []

date: 2008-11-12 00:00:00 -05:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: colored
  type: :runtime
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "1.1"
    version: 
description: git_remote_branch is a learning tool to ease the interaction with remote branches in simple situations.
email: webmat@gmail.com
executables: 
- grb
extensions: []

extra_rdoc_files: 
- README.rdoc
files: 
- bin
- bin/grb
- CHANGELOG
- COPYING
- lib
- lib/git_remote_branch.rb
- lib/param_reader.rb
- lib/state.rb
- lib/string_ext.rb
- lib/version.rb
- Rakefile
- README.rdoc
- tasks
- tasks/gem.rake
- tasks/rdoc.rake
- tasks/test.rake
- test
- test/functional
- test/functional/grb_test.rb
- test/helpers
- test/helpers/array_extensions.rb
- test/helpers/constants.rb
- test/helpers/extractable.rb
- test/helpers/git_helper.rb
- test/helpers/in_dir.rb
- test/helpers/more_assertions.rb
- test/helpers/shoulda_functional_helpers.rb
- test/helpers/shoulda_unit_helpers.rb
- test/helpers/temp_dir_helper.rb
- test/test_helper.rb
- test/unit
- test/unit/git_helper_test.rb
- test/unit/git_remote_branch_test.rb
- test/unit/param_reader_test.rb
- test/unit/state_test.rb
- vendor
- vendor/capture_fu.rb
has_rdoc: true
homepage: http://github.com/webmat/git_remote_branch
post_install_message: 
rdoc_options: 
- --main
- README.rdoc
- --exclude
- lib
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
requirements: []

rubyforge_project: grb
rubygems_version: 1.3.0
signing_key: 
specification_version: 2
summary: git_remote_branch eases the interaction with remote branches
test_files: 
- test/functional
- test/functional/grb_test.rb
- test/helpers
- test/helpers/array_extensions.rb
- test/helpers/constants.rb
- test/helpers/extractable.rb
- test/helpers/git_helper.rb
- test/helpers/in_dir.rb
- test/helpers/more_assertions.rb
- test/helpers/shoulda_functional_helpers.rb
- test/helpers/shoulda_unit_helpers.rb
- test/helpers/temp_dir_helper.rb
- test/test_helper.rb
- test/test_runs
- test/test_runs/2973
- test/test_runs/2973/remote
- test/test_runs/2973/remote/file.txt
- test/test_runs/4956
- test/test_runs/4956/local1
- test/test_runs/4956/local1/file.txt
- test/test_runs/4956/local2
- test/test_runs/4956/local2/file.txt
- test/test_runs/4956/remote
- test/test_runs/4956/remote/file.txt
- test/test_runs/5197
- test/test_runs/5197/remote
- test/test_runs/5197/remote/file.txt
- test/test_runs/7147
- test/test_runs/7147/remote
- test/test_runs/7147/remote/file.txt
- test/unit
- test/unit/git_helper_test.rb
- test/unit/git_remote_branch_test.rb
- test/unit/param_reader_test.rb
- test/unit/state_test.rb
