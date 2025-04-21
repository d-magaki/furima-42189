document.addEventListener("turbo:load", initializePriceCalculator);
document.addEventListener("turbo:render", initializePriceCalculator);

function initializePriceCalculator() {
  const priceInput = document.getElementById("item-price");
  
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value.trim();
    if (inputValue !== "" && !isNaN(parseInt(inputValue))) {
      const fee = Math.floor(inputValue * 0.1);
      const profit = Math.floor(inputValue - fee);

      document.getElementById('add-tax-price').innerText = fee.toLocaleString();
      document.getElementById('profit').innerText = profit.toLocaleString();
    } else {
      document.getElementById('add-tax-price').innerText = 0;
      document.getElementById('profit').innerText = 0;
    }
  });
}