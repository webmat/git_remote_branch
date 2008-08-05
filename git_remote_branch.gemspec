--- !ruby/object:Gem::Specification 
name: git_remote_branch
version: !ruby/object:Gem::Version 
  version: 0.2.6
platform: ruby
authors: 
- Mathieu Martin
- Carl Mercier
autorequire: 
bindir: bin
cert_chain: []

date: 2008-08-05 00:00:00 -04:00
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

extra_rdoc_files: []

files: 
- bin
- bin/grb
- COPYING
- lib
- lib/git_remote_branch.rb
- lib/param_reader.rb
- lib/version.rb
- Rakefile
- README
- tasks
- tasks/gem.rake
- tasks/test.rake
- test
- test/functional
- test/functional/grb_test.rb
- test/helpers
- test/helpers/array_extensions.rb
- test/helpers/dir_stack.rb
- test/helpers/extractable.rb
- test/helpers/git_helper.rb
- test/helpers/more_assertions.rb
- test/helpers/shoulda_functional_helpers.rb
- test/helpers/shoulda_unit_helpers.rb
- test/helpers/temp_dir_helper.rb
- test/test_helper.rb
- test/unit
- test/unit/git_helper_test.rb
- test/unit/git_remote_branch_test.rb
- test/unit/param_reader_test.rb
- TODO
- vendor
- vendor/capture_fu.rb
has_rdoc: false
homepage: http://github.com/webmat/git_remote_branch
post_install_message: 
rdoc_options: []

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
rubygems_version: 1.2.0
signing_key: 
specification_version: 2
summary: git_remote_branch eases the interaction with remote branches
test_files: 
- test/functional
- test/functional/grb_test.rb
- test/helpers
- test/helpers/array_extensions.rb
- test/helpers/dir_stack.rb
- test/helpers/extractable.rb
- test/helpers/git_helper.rb
- test/helpers/more_assertions.rb
- test/helpers/shoulda_functional_helpers.rb
- test/helpers/shoulda_unit_helpers.rb
- test/helpers/temp_dir_helper.rb
- test/test_helper.rb
- test/unit
- test/unit/git_helper_test.rb
- test/unit/git_remote_branch_test.rb
- test/unit/param_reader_test.rb
