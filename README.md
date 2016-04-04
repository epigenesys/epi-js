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

#### Via data attribute
Add `data-toggle=ajax-modal` to your link
#### Via class
Add `ajax-modal` class to your link
#### Via JavaScript

    $.ajaxModal(url);

### Flash Message
Add to your `app/assets/javascripts/application.js`

    //= require flash_message

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

#### Customisation
You can change the markup of the dismiss link by setting the following variable:

    $.flashAlert.defaults.dismissLink

### Option Filter
Add to your `app/assets/javascripts/application.js`

    //= require option_filter

#### Via data attributes
Add the jQuery selector of the target input as `data-option-filter-target` to the source input, e.g.

    data-option-filter-target="#input-box-1"

To show an option in the target input when an option is selected in the source input, add the value of the source input as `data-option-filter-value`, e.g.

    data-option-filter-value="1"

When the option with value 1 is selected in source input, only options with `data-option-filter-value="1"` will be displayed.

You can also add `data-option-filter-disable-empty` to the source input, so that when there is no options available for the current value, the target input will be disabled.

### Responsive Table

Add to your `app/assets/javascripts/application.js`

    //= require responsive_table

And to your `app/assets/stylesheets/application.css`
  
    *= require responsive_table

Then add `.table-responsive-xs` or `.table-responsive-sm` to tables.
You can override the label for each table cell by adding `data-label` to the `td` element.

### Visibility Map
Add to your `app/assets/javascripts/application.js`

    //= require visibility_map

#### Via data attributes
Set `data-visibility-map` of a select box, radio button group or check boxes to a JSON string, e.g.

    data-visibility-map='{"foo":"#foo","bar":"#bar"}'
Or for SimpleForm, use:

    f.input :some_select, input_html: {data: {visibility_map: {foo: '#foo', bar: '#bar'}}}

When the value of the input element is `foo`, the element `#foo` will be visible and `#bar` will be hidden, and vice versa. The value of the JSON key value pair can be any jQuery selectors.