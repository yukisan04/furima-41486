function count(){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    profitDom.innerHTML = Math.floor(inputValue - inputValue * 0.1);
  });
};

const price = () => {
  count();
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);