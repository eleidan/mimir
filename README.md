# Mimir
[![Code Climate](https://codeclimate.com/github/eleidan/mimir/badges/gpa.svg)](https://codeclimate.com/github/eleidan/mimir)
[![Test Coverage](https://codeclimate.com/github/eleidan/mimir/badges/coverage.svg)](https://codeclimate.com/github/eleidan/mimir)
[![Build Status](https://travis-ci.org/eleidan/mimir.svg)](https://travis-ci.org/eleidan/mimir)
[![security](https://hakiri.io/github/eleidan/mimir/master.svg)](https://hakiri.io/github/eleidan/mimir/master)

Introspection utility for Ruby language.

## Usage
Once the application's repository is obtained, it is possible to give it a try.
Go into the application's directory and issue the following command:
```
ruby -Ilib bin/mimir
```
As a result, the following output or similar is expected:
```
Introspection utility for Ruby language.

Usage:
  mimir [command] [options]
  mimir help <command>
  mimir --help
  mimir --version

Commands:
  dump              Get list of all objects in provided class.
  help              Print information about the command use.

Options:
      --help        Show this help end exit.
      --version     Show application version end exit.
```

## Supported Ruby Versions
The application is tested with the following Ruby versions:
- MRI 2.1.0
- MRI 2.2.0

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mimir/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
[GNU General Public License, version 3](http://www.gnu.org/licenses/gpl-3.0.html)
