# EpiJS

Some jQuery based scripts, including:

* A simple AJAX lightbox using Twitter Bootstrap modal
* A simple Growl-like using Twitter Bootstrap alert
* A script to hide / show HTML elements based on user input

## Installation

Add this line to your application's Gemfile:

    gem 'epi_js'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install epi_js

## Usage

### AJAX Modal
Add to your `app/assets/javascripts/application.js`

	//= require ajax_modal
#### Via class
Add `ajax-modal` class to your link
#### Via JavaScript
	$.ajaxModal(url);

### Flash Message
Add to your `app/assets/javascripts/application.js`

	//= require flash_message
And to your `app/assets/stylesheets/application.css`

	*= require flash_message
#### For Rails flash fessage
Wrap your flash message in a div with `.flash_messages` class, e.g.

	.flash-messages
      - unless flash.blank?
        - flash.each do |name, msg|
          .alert.fade{ class: "alert-#{ name == :notice ? 'success' : 'error' }" }
            %a.close{ data: { dismiss: :alert } } &times;
            = msg
#### Via JavaScript
	$.flashAlert(message, alert_class);
`alert_class` is `alert-notice` etc.

### Visibility Map
Add to your `app/assets/javascripts/application.js`

	//= require visibility_map
#### Via data attributes
Set `data-visibility-map` of a select box or radio button group to a JSON string, e.g.
	
	data-visibility-map='{"foo":"#foo","bar":"#bar"}'
Or for SimpleForm, use:
	
	f.input :some_select, input_html: {data: {visibility_map: {foo: '#foo', bar: '#bar'}}}
	
When the value of the input element is `foo`, the element `#foo` will be visible and `#bar` will be hidden, and vice versa. The value of the JSON key value pair can be any jQuery selectors.