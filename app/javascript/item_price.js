document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      console.log("Debug: Input Price Value =", priceInput.value);

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
});