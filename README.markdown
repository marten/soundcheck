A smarter way to run your tests
===============================

Soundcheck is a universal test runner. It automatically detects what testing
frameworks you use, and how to run your tests. You can pass it a filename,
and it'll run just those tests.

One benefit of this is that you can set your editor to simply run `soundcheck
$filename`, and soundcheck will figure out how to run that test.

Soundcheck will also try to run your tests as fast as possible.

## Is Soundcheck not working for your project?

Feel free to submit a pull request that adds only a fixture and RSpec testcase
which describes the situation in which it fails. If you can fix it yourself,
then great, but I'll happily accept patches that add more project styles which
Soundcheck currently can't handle.

## Contributing to Soundcheck
 
* Check out the latest master to make sure the feature hasn't been implemented
  or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it
  and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to
  have your own version, or is otherwise necessary, that is fine, but please
  isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Marten Veldthuis. See LICENSE.txt for further details.

This gem started as a Ruby version of Gary Bernhardt's 'script/test' from
[Destroy All Software's screencast number 10][1].

[1]: http://destroyallsoftware.com/screencasts/catalog/fast-tests-with-and-without-rails
