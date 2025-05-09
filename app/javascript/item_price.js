// app/javascript/item_price.js

  document.addEventListener("turbo:load", () => {
    const priceInput = document.getElementById("item-price");
    const feeDisplay = document.getElementById("fee");
    const profitDisplay = document.getElementById("profit");
  
    if (!priceInput || !feeDisplay || !profitDisplay) return;
  
 
  const newPriceInput = priceInput.cloneNode(true);
  priceInput.parentNode.replaceChild(newPriceInput, priceInput);

  newPriceInput.addEventListener("input", () => {
    const value = parseInt(newPriceInput.value, 10);

    if (isNaN(value) || value < 300 || value > 9999999) {
      feeDisplay.textContent = "";
      profitDisplay.textContent = "";
      return;
    }

    const fee = Math.floor(value * 0.1);
    const profit = value - fee;

    feeDisplay.textContent = fee;
    profitDisplay.textContent = profit;
  });
});
