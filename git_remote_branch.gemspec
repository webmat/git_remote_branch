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
- coverage
- coverage/-Library-Ruby-Gems-1_8-gems-colored-1_1-lib-colored_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-any_instance_method_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-auto_verify_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-central_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-class_method_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-deprecation_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-exception_raiser_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-expectation_error_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-expectation_list_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-expectation_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-infinite_range_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-inspect_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-instance_method_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-is_a_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-metaclass_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-method_matcher_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-missing_expectation_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-mock_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-multiple_yields_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-no_yields_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-object_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-all_of_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-any_of_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-any_parameters_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-anything_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-base_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-equals_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-has_entries_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-has_entry_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-has_key_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-has_value_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-includes_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-instance_of_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-is_a_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-kind_of_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-not_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-object_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-optionally_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers-regexp_matches_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameter_matchers_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-parameters_matcher_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-return_values_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-sequence_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-setup_and_teardown_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-single_return_value_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-single_yield_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-standalone_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-stub_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-test_case_adapter_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha-yield_parameters_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-mocha-0_5_6-lib-mocha_standalone_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-rcov-0_8_1_2_0-lib-rcov_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-redgreen-1_2_2-lib-redgreen_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-command_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-breakpoints_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-catchpoint_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-control_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-display_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-enable_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-eval_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-frame_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-help_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-info_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-irb_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-list_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-method_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-script_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-settings_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-show_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-stepping_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-threads_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-tmate_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-trace_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-commands-variables_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-helper_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-interface_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug-processor_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-0_10_0-cli-ruby-debug_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-ruby-debug-base-0_10_0-lib-ruby-debug-base_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-Shoulda-1_1_1-lib-proc_extensions_rb.html
- coverage/-Library-Ruby-Gems-1_8-gems-Shoulda-1_1_1-lib-shoulda_rb.html
- coverage/index.html
- coverage/lib-git_remote_branch_rb.html
- coverage/lib-param_reader_rb.html
- coverage/lib-version_rb.html
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
