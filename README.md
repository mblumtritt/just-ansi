# JustAnsi ![version](https://img.shields.io/gem/v/just-ansi?label=)

Simple and fast ANSI control code processing. <!-- Without BS. -->

- Gem: [rubygems.org](https://rubygems.org/gems/just-ansi)
- Source: [github.com](https://github.com/mblumtritt/just-ansi)
- Help: [rubydoc.info](https://rubydoc.info/gems/just-ansi/JustAnsi)

## Description

JustAnsi provides a rich set of methods to generate ANSI control codes for attributes, colors, cursor movement and much more. It supports most control codes, all attributes, 3/4bit-, 8bit- and 24bit-colors.

```ruby
hello = JustAnsi.decorate('Hello World!', :bold, :red)
# => "\e[1;31mHello World!\e[m"

JustAnsi.undecorate(hello)
# => 'Hello World!'

JustAnsi.bbcode('[b]Hello [red]World[/fg]![/b]')
# => "\e[1mHello \e[31mWorld\e[39m!\e[22m"
```

## Help

📕 See the [online help](https://rubydoc.info/gems/just-ansi/JustAnsi) and have a look at the [examples](./examples/) directory.

### Run Examples

You can execute the examples by

```sh
ruby ./examples/bbcode.rb
```

## Installation

You can install the gem in your system with

```shell
gem install just-ansi
```

or you can use [Bundler](http://gembundler.com/) to add JustAnsi to your own project:

```shell
bundle add just-ansi
```

After that you only need one line of code to have everything together

```ruby
require 'just-ansi'
```
