# Gurk

A ruby microframework for the masses. You don't need a programming background all you need is the english language. 

Perfect for designers or any developers that don't want to write code at all.

## Installation

    gem install gurk

Create a new gurk project by running

    gurk new <appname>
    cd <appname>

You should see a directory with the following structure

    app/
      assets/
      views/home.html.erb
      views/layout.html.erb
    features/
    features/home.erb
    public/
    vendor/
    Gemfile

## Features

Create a basic feature file with the following

  Feature: My site

    Scenario: Home Page
      Given I have a page called 'Home'
      And it has a title called 'home'
      And it has a route of '/'
      When I visit '/'
      Then I should see 'home'

    Scenario: About
      Given I have a page called 'About'
      And it has a title called 'About Us'
      And it has a route of '/about'
      When I visit '/about'
      Then I should see 'About Us'

More information and examples can be found at the Wiki.

## Template Support

Gurk supports Tilt. A template wrapper that gives you the flexibility to choose which

If you're using haml, just add the following in your Gemfile

    gem 'haml'

Don't forget to run bundle install

## Tests

Gurk supports tests! In fact we do sanity check per each request during development.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contributors

Vixon - The Jason Torres and Victor Solis show.

## License

MIT License
