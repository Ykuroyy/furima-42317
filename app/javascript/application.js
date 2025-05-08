// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
  const errorBox = document.querySelector("#error_explanation");
  if (errorBox) {
    errorBox.scrollIntoView({ behavior: "smooth", block: "start" });
  }
});

import "item_price"