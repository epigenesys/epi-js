# AJAX Modal

## Description

A simple AJAX lightbox using Twitter Bootstrap modal. Allows a link to render the returned html inside a modal window,
and can handle returned JavaScript from forms within the modal.

## Getting started

### Installing

1. Ensure epi-js is installed.

2. Ensure that jQuery is installed and available for use.

3. Ensure your CSP is setup to support nonce generation.
You might need to add the following code to `config/initializers/content_security_policy.rb`.

```ruby
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w(script-src)
```

### Basic usage (read-only modal)

Setup a controll as normal, but ensure that you render with the `layout: false` option to avoid including the navigation and layout in the modal. For example:

```ruby
class BooksController < ApplicationController

  def new
    @book = Book.new
    render layout: false
  end
end
```

In your view add the html that you want to appear inside the modal. For example:

```haml
.modal-dialog{ role: "document" }
  .modal-content
    .modal-header
      %h5.modal-title Modal Title
      %button.close{ data: { dismiss: "modal" }, aria: { label: "close" } }
        %span{ aria: { hidden: "true" } } &times;
    .modal-body
      %p Modal body goes here
    .modal-footer
```

Add either `data-toggle=ajax-modal` or a class of `ajax-modal` to the link or button that you want to open the modal. For example:

```haml
  = link_to new_book_path, "Add a new book", data: { toggle: "ajax-modal" }
```

### Handling forms within modals

Setup an AJAX modal as detailed above in the Basic usage section, and edit the haml to include your form. Make sure that the form uses `remote: true`. For example:

```haml
.modal-dialog{ role: "document" }
  .modal-content
    .modal-header
      %h5.modal-title Modal Title
      %button.close{ data: { dismiss: "modal" }, aria: { label: "close" } }
        %span{ aria: { hidden: "true" } } &times;
    = simple_form_for @book, remote: true do |f|
      .modal-body
        = f.input :author
        = f.input :title
      .modal-footer
        = f.submit
```

Setup the controller to respond to JS, and return `create_success.js.haml` or `created_failure.js.haml`. For example:

```ruby
class BooksController < ApplicationController
  respond_to :html, except: [:create]
  respond_to :js, only: [:create]

  def new
    @book = Book.new
    render layout: false
  end

  def edit
    @book = Book.new
    @book.assign_attributes(book_params)
    if @book.save
      respond_with(@faq) do |format|
        format.js { render "create_success" }
      end
    else
      respond_with(@faq) do |format|
        format.js { render "create_failure" }
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:author, :title)
  end
end
```

The JavaScript contained within the `create_success.js.haml` or `created_failure.js.haml` will then be executed once it is returned to the page. The following is a simple example that will re-render the modal on failure, or refresh the page on success.

create_success.js.haml
```javascript
location.reload();
```

create_failure.js.haml
```javascript
$('#modalWindow .modal-dialog').replaceWith('#{j render template: 'books/new' }');
```

