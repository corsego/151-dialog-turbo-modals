// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import {Turbo} from "@hotwired/turbo-rails"

// turbo_stream.action(:redirect, comments_path)
Turbo.StreamActions.redirect = function() {
  Turbo.visit(this.target)
}

// turbo_stream.advanced_redirect(comments_path)
Turbo.StreamActions.advanced_redirect = function() {
  let url = this.getAttribute('url')
  console.log(url)
  Turbo.visit(url)
}
