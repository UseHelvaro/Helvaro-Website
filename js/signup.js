/* ============================================================
   AANMELDEN — koppeling naar de applicatie
   ------------------------------------------------------------
   De marketingsite maakt zelf geen accounts aan. Het account
   wordt gemaakt in de beveiligde omgeving van de app. Deze
   pagina vangt het e-mailadres op, valideert het, en stuurt de
   bezoeker door met dat adres alvast ingevuld.

   Sinds 31-08-2026 gaat dit naar app.helvaro.pro/signup en NIET meer
   naar accounts.helvaro.pro/sign-up.

   Waarom: dat laatste is Clerk's eigen portaal. Dat werkt, maar het is
   onze site niet. Het staat in het Engels ("Create your account"), in
   Clerks paarse standaardthema, zonder ons logo, zonder een woord over
   de proefperiode van veertien dagen. Een Vlaamse makelaar klikt dus
   vanaf een Nederlandse pagina door naar een Engels paars formulier van
   een partij waar hij nog nooit van gehoord heeft -- precies op het
   moment dat hij beslist of hij ons vertrouwt.

   app.helvaro.pro/signup toont hetzelfde registratieformulier van Clerk,
   maar in ons eigen scherm: logo, huisstijl, het promopaneel ernaast, en
   in de taal van de bezoeker. De inloglink op deze site wijst al naar
   app.helvaro.pro, dus dit maakt het ook consistent.

   De parameter email_address blijft werken: die pagina vult het adres
   voor in het formulier.
   Wil je de bestemming wijzigen, pas dan alleen SIGNUP_URL aan.
   ============================================================ */
(function () {
  'use strict';

  var SIGNUP_URL = 'https://app.helvaro.pro/signup';
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
