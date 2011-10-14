A smarter way to run your tests
===============================

This gem started as a Ruby version of 'script/test' from Destroy All Software's
screencast number 10. This script is available [here][1].

The basic idea is that sometimes it's not necessary to run rspec through bundler,
and it's possible to save a whole bunch of time off your test runs if it isn't. This script
will attempt to determine whether you want the entire Gemfile required and ready, by looking
whether you reference `spec_helper`. For Rails applications, this is reasonable, because if
you require that file, you'll probably need all of Rails loaded. If you don't (as you can
often do when running a spec for something you put in `Rails.root.join("lib")`), it'll execute
"rspec $0", otherwise it'll execute "bundle exec rspec $0".

  [1] http://destroyallsoftware.com/screencasts/catalog/fast-tests-with-and-without-rails

## Contributing to smart-test-runner
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Marten Veldthuis. See LICENSE.txt for further details.

