/* ============================================================
   AANMELDEN — koppeling naar de applicatie
   ------------------------------------------------------------
   De marketingsite maakt zelf geen accounts aan. Het account
   wordt gemaakt in de beveiligde omgeving van de app. Deze
   pagina vangt het e-mailadres op, valideert het, en stuurt de
   bezoeker door met dat adres alvast ingevuld.

   Geverifieerd op 31-08-2026: zelfaanmelden staat open. De pagina
   toont een echt registratieformulier (e-mail, wachtwoord, Google) en
   de parameter email_address vult het e-mailveld daar vooraf in.
   Wil je de bestemming wijzigen, pas dan alleen SIGNUP_URL aan.
   ============================================================ */
(function () {
  'use strict';

  var SIGNUP_URL = 'https://accounts.helvaro.pro/sign-up';
  var EMAIL_PARAM = 'email_address';

  var form = document.getElementById('signupForm');
  if (!form) return;

  var input = document.getElementById('signupEmail');
  var error = document.getElementById('signupError');
  var button = form.querySelector('.signup-submit');

  // Bewust ruim: e-mailvalidatie die te streng is, weigert echte adressen.
  var EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

  function showError(message) {
    error.textContent = message;
    error.hidden = false;
    input.setAttribute('aria-invalid', 'true');
    input.focus();
  }

  function clearError() {
    error.hidden = true;
    error.textContent = '';
    input.removeAttribute('aria-invalid');
  }

  input.addEventListener('input', clearError);

  form.addEventListener('submit', function (event) {
    event.preventDefault();

    var email = (input.value || '').trim();

    if (!email) {
      showError('Vul je e-mailadres in om verder te gaan.');
      return;
    }
    if (!EMAIL_RE.test(email)) {
      showError('Dit e-mailadres lijkt niet te kloppen. Controleer het even.');
      return;
    }

    clearError();
    button.disabled = true;
    button.classList.add('is-loading');
    button.textContent = 'Een moment…';

    var url;
    try {
      url = new URL(SIGNUP_URL);
      url.searchParams.set(EMAIL_PARAM, email);
    } catch (e) {
      // Kan de URL niet opgebouwd worden, ga dan zonder parameter door
      // in plaats van de bezoeker te laten stranden.
      window.location.href = SIGNUP_URL;
      return;
    }

    window.location.href = url.toString();
  });
})();
