// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "item_price"

// document.addEventListener("DOMContentLoaded", () => {
document.addEventListener("turbo:load", () => {
 
  const errorBox = document.querySelector("#error_explanation");
  if (errorBox) {
    errorBox.scrollIntoView({ behavior: "smooth", block: "start" });
  }
});



