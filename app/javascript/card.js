const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form) return; // 他ページ読み込み時の安全対策

  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener('submit', (e) => {
    e.preventDefault(); // 二重送信防止

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert(response.error.message);
      } else {
        const token = response.id;
        const tokenInput = `<input value="${token}" type="hidden" name="order_shipping[token]" id="token">`;
        form.insertAdjacentHTML("beforeend", tokenInput);

        form.submit(); // トークンを追加したら送信

        // clearはsubmit後は基本不要ですが、念のため
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
      }
    });
  });
};

window.addEventListener('turbo:load', pay);
window.addEventListener('turbo:render', pay);
