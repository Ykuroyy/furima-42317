// app/javascript/item_price.js

const handleInput = (event) => {
  const value = parseInt(event.target.value, 10);
  const feeDisplay = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById("profit");

  if (!feeDisplay || !profitDisplay) return;

  if (isNaN(value) || value < 300 || value > 9999999) {
    feeDisplay.textContent = '';
    profitDisplay.textContent = '';
    return;
  }

  const fee = Math.floor(value * 0.1);
  const profit = value - fee;

  feeDisplay.textContent = fee.toLocaleString();
  profitDisplay.textContent = profit.toLocaleString();
};

const setupPriceCalculation = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.removeEventListener("input", handleInput);
  priceInput.addEventListener("input", handleInput);
};

// Turbo対応
window.addEventListener("turbo:load", setupPriceCalculation);
window.addEventListener("turbo:render", setupPriceCalculation);

