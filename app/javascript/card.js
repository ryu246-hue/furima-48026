const setupCard = () => {
  const form = document.getElementById("charge-form");

  if (!form || form.dataset.cardInitialized === "true") return;

  const publicKey = form.dataset.payjpPublicKey;
  if (!publicKey || typeof Payjp === "undefined") return;

  const numberForm = document.getElementById("number-form");
  const expiryForm = document.getElementById("expiry-form");
  const cvcForm = document.getElementById("cvc-form");

  if (!numberForm || !expiryForm || !cvcForm) return;

  form.dataset.cardInitialized = "true";

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const button = document.getElementById("button");
    if (button) button.disabled = true;

    try {
      const result = await payjp.createToken(numberElement);

      if (result.error) {
        alert(result.error.message);
        if (button) button.disabled = false;
        return;
      }

      const tokenInput = document.getElementById("token");
      tokenInput.value = result.id;

      form.submit();
    } catch (error) {
      alert("カード情報の処理に失敗しました。");
      if (button) button.disabled = false;
    }
  });
};

document.addEventListener("turbo:load", setupCard);
document.addEventListener("turbo:render", setupCard);
document.addEventListener("DOMContentLoaded", setupCard);
