const price = () => {
  const priceInput = document.getElementById("item-price");

  if (!priceInput) return;

  const calculatePrice = () => {
    const inputValue = Number(priceInput.value);

    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (!addTaxPrice || !profit) return;

    if (priceInput.value === "") {
      addTaxPrice.textContent = "";
      profit.textContent = "";
      return;
    }

    const fee = Math.floor(inputValue * 0.1);
    const profitValue = Math.floor(inputValue - fee);

    addTaxPrice.textContent = fee;
    profit.textContent = profitValue;
  };

  priceInput.addEventListener("input", calculatePrice);

  calculatePrice();
};

document.addEventListener("turbo:load", price);
document.addEventListener("DOMContentLoaded", price);
document.addEventListener("turbo:render", price);