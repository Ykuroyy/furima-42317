// app/javascript/item_price.js

// document.addEventListener("DOMContentLoaded", () => {
document.addEventListener("turbo:load", () => {  
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const value = parseInt(priceInput.value, 10);
    const tax = Math.floor(value * 0.1);
    const profit = value - tax;

    const taxDisplay = document.getElementById("add-tax-price");
    const profitDisplay = document.getElementById("profit");

    if (taxDisplay && profitDisplay && !isNaN(value)) {
      taxDisplay.textContent = tax;
      profitDisplay.textContent = profit;
    } else {
      taxDisplay.textContent = "";
      profitDisplay.textContent = "";
    }
  });
});

