# Gurk

A ruby microframework for the masses. You don't need a programming background all you need to know is the English language. 

Perfect for designers, people who doesn't want to get their hands dirty coding.

## Installation

    gem install gurk

Create a new gurk project by running

    gurk new <appname>
    cd <appname>

You should see a directory with the following structure

    app/
      assets/
      views/
      views/layouts/application.html.erb
    features/
    public/
    vendor/
    Gemfile
    config.ru

## Features

Create a basic feature file with the following

    Given I have a home page
    And with the path "/"
    And with the title "Home Page"
    When I visit "/"
    Then I should see the home page
    And I should see "this and that content"
    
More information and examples can be found at the Wiki.

## Running

Gurk runs on top of rack. Rack is supported by almost all ruby servers. To run, just type in the following

    rackup 

## Templates

Gurk supports Tilt. A template wrapper that gives you the flexibility to choose which

If you're using haml, just add the following in your Gemfile

    gem 'haml'

Don't forget to run bundle install


## Overiding generated pages

For each page generated from the feature scenarios. We create an object that you can easily override. For this feature.


    Given I have a home page
    And with the path "/"
    And with the title "Home Page"
    And with the layout "

Add a file called app/home.rb

    class HomePage
      include Gurk::Methods

      local :page_title, 'This is the new title' 
      local :header, 'The most awesome site ever'

      path '/homepage'
    end

## Creating your own pages

Ok fine, you don't want to use the features feature. We suggest to using Sinatra instead :).

However, you are free to do so by doing the following

Create a file called app/contact.rb

    class ContactPage
      include Gurk::Methods

      name 'contact'
      local :title, "Contact Page"
      path '/contact'

    end

Don't forget to create your view. For example: app/views/contact.html.erb 

Then register it to Gurk in your app.rb file.

    Gurk::Router.register ContactPage

## Tests

Gurk supports tests! In fact we do sanity check per each request during development.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Contributors

Vixon

## License

MIT License
