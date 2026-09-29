/* ============================================================================
   FARO — de assistent op de site zelf
   ----------------------------------------------------------------------------
   Een venster waarin een bezoeker vragen over Helvaro kan stellen. Het antwoord
   komt van /api/faq, dat alleen uit de eigen kennisbank put en alles wat niet
   over Helvaro gaat weigert.

   WAAROM DIT FARO IS EN GEEN LOSSE CHATBEL
   Rechtsonder stond al een mascotte die per sectie uitlegt waar je naar kijkt.
   Daar een tweede, generieke chatbel naast zetten geeft de bezoeker twee
   assistenten op één pagina. Dus is de knop Faro zelf: dezelfde figuur, nu
   aanklikbaar. Zolang het venster openstaat zwijgt de rondlopende gids, anders
   praten ze door elkaar heen.

   WAT DE BROWSER NIET BEPAALT
   De geschiedenis gaat mee in het verzoek en is dus te vervalsen. Dat mag: de
   server kapt hem af op zijn eigen maximum en rekent nergens op wat hier staat.
   Alles wat de bot wel of niet mag zeggen wordt aan de serverkant beslist.
   ========================================================================= */
(function () {
  'use strict';

  var EINDPUNT = '/api/faq';
  var MAX_TEKENS = 500;
  var MAX_BEURTEN = 14;

  var T = {
    nl: { titel: 'Vraag het Faro', onder: 'Alleen over Helvaro', plaats: 'Stel je vraag over Helvaro',
          open: 'Stel een vraag over Helvaro', sluit: 'Sluiten', stuur: 'Versturen',
          fout: 'Er ging iets mis. Probeer het zo nog eens.',
          welkom: 'Ik beantwoord vragen over Helvaro: de werkstromen, de kanalen, de koppelingen en de prijzen. Wat wil je weten?',
          op: 'Dit gesprek is lang genoeg geweest. Voor de rest kun je het team spreken.' },
    fr: { titel: 'Demandez à Faro', onder: 'Uniquement sur Helvaro', plaats: 'Posez votre question sur Helvaro',
          open: 'Poser une question sur Helvaro', sluit: 'Fermer', stuur: 'Envoyer',
          fout: 'Une erreur est survenue. Réessayez dans un instant.',
          welkom: 'Je réponds aux questions sur Helvaro : les flux, les canaux, les intégrations et les tarifs. Que voulez-vous savoir ?',
          op: 'Cette conversation a assez duré. Pour le reste, parlez à l’équipe.' },
    en: { titel: 'Ask Faro', onder: 'About Helvaro only', plaats: 'Ask your question about Helvaro',
          open: 'Ask a question about Helvaro', sluit: 'Close', stuur: 'Send',
          fout: 'Something went wrong. Try again in a moment.',
          welkom: 'I answer questions about Helvaro: the workflows, the channels, the integrations and the pricing. What would you like to know?',
          op: 'This conversation has run long enough. For the rest, talk to the team.' },
    de: { titel: 'Faro fragen', onder: 'Nur zu Helvaro', plaats: 'Ihre Frage zu Helvaro',
          open: 'Eine Frage zu Helvaro stellen', sluit: 'Schließen', stuur: 'Senden',
          fout: 'Da ging etwas schief. Versuchen Sie es gleich noch einmal.',
          welkom: 'Ich beantworte Fragen zu Helvaro: die Abläufe, die Kanäle, die Anbindungen und die Preise. Was möchten Sie wissen?',
          op: 'Dieses Gespräch war lang genug. Für alles Weitere sprechen Sie das Team.' },
    es: { titel: 'Pregunta a Faro', onder: 'Solo sobre Helvaro', plaats: 'Haz tu pregunta sobre Helvaro',
          open: 'Hacer una pregunta sobre Helvaro', sluit: 'Cerrar', stuur: 'Enviar',
          fout: 'Algo ha ido mal. Inténtalo de nuevo en un momento.',
          welkom: 'Respondo preguntas sobre Helvaro: los flujos, los canales, las integraciones y los precios. ¿Qué quieres saber?',
          op: 'Esta conversación ya ha sido bastante larga. Para lo demás, habla con el equipo.' },
  };

  function taal() {
    var l = (document.documentElement.lang || 'nl').slice(0, 2);
    return T[l] ? l : 'nl';
  }

  /* De pagina's staan op drie diepten en onder vijf taalmappen, dus een vast
     pad naar de afbeelding klopt alleen in de hoofdmap. We lezen het voorvoegsel
     af van een plaatje dat al in de pagina staat; dat pad is door de bouwstap
     goed gezet. */
  function basis() {
    var img = document.querySelector('img[src*="assets/"]');
    var src = img && img.getAttribute('src');
    var m = src && src.match(/^(.*?)assets\//);
    return m ? m[1] : '';
  }

  function el(tag, klasse, tekst) {
    var n = document.createElement(tag);
    if (klasse) n.className = klasse;
    if (tekst != null) n.textContent = tekst;
    return n;
  }

  function init() {
    if (document.querySelector('.fb-knop')) return;
    var t = T[taal()];
    var rustig = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var historie = [];
    var bezig = false;
    var open = false;

    /* ── De knop: Faro zelf ─────────────────────────────────────────────── */
    var knop = el('button', 'fb-knop');
    knop.type = 'button';
    knop.setAttribute('aria-label', t.open);
    knop.setAttribute('aria-expanded', 'false');
    var img = el('img', 'fb-knop-img');
    img.src = basis() + 'assets/faro/falcon-idle.webp';
    img.alt = '';
    img.width = 64; img.height = 64;
    img.setAttribute('aria-hidden', 'true');
    knop.appendChild(img);
    knop.appendChild(el('span', 'fb-knop-stip'));

    /* ── Het venster ────────────────────────────────────────────────────── */
    var paneel = el('div', 'fb-paneel');
    paneel.setAttribute('role', 'dialog');
    paneel.setAttribute('aria-label', t.titel);
    paneel.hidden = true;

    var kop = el('div', 'fb-kop');
    var kopT = el('div', 'fb-kop-tekst');
    kopT.appendChild(el('span', 'fb-titel', t.titel));
    kopT.appendChild(el('span', 'fb-onder', t.onder));
    kop.appendChild(kopT);
    var dicht = el('button', 'fb-dicht', '×');
    dicht.type = 'button';
    dicht.setAttribute('aria-label', t.sluit);
    kop.appendChild(dicht);
    paneel.appendChild(kop);

    var draad = el('div', 'fb-draad');
    draad.setAttribute('role', 'log');
    draad.setAttribute('aria-live', 'polite');
    paneel.appendChild(draad);

    var form = el('form', 'fb-form');
    var veld = el('input', 'fb-veld');
    veld.type = 'text';
    veld.maxLength = MAX_TEKENS;
    veld.placeholder = t.plaats;
    veld.setAttribute('aria-label', t.plaats);
    veld.autocomplete = 'off';
    var verstuur = el('button', 'fb-stuur');
    verstuur.type = 'submit';
    verstuur.setAttribute('aria-label', t.stuur);
    verstuur.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M5 12h13M13 6l6 6-6 6"/></svg>';
    form.appendChild(veld);
    form.appendChild(verstuur);
    paneel.appendChild(form);

    document.body.appendChild(knop);
    document.body.appendChild(paneel);

    /* Zegt tegen de opmaak dat de knop bestaat. De rondlopende gids verbergt
       dan zijn eigen valk en schuift omhoog, zodat er één Faro op het scherm
       staat en zijn ballon boven de knop zweeft. Staat dit script er niet,
       dan blijft de gids onveranderd. */
    document.documentElement.classList.add('fb-aan');

    /* ── Berichten ──────────────────────────────────────────────────────── */
    function zeg(rol, tekst, cta) {
      var rij = el('div', 'fb-bericht fb-' + (rol === 'user' ? 'ik' : 'faro'));
      rij.appendChild(el('div', 'fb-bel', tekst));
      if (cta && cta.pad && cta.tekst) {
        var a = el('a', 'fb-cta', cta.tekst);
        a.href = basis() ? basis().replace(/(\.\.\/)+$/, '') + cta.pad.replace(/^\//, '') : cta.pad;
        rij.appendChild(a);
      }
      draad.appendChild(rij);
      draad.scrollTop = draad.scrollHeight;
      return rij;
    }

    function typt(aan) {
      var b = draad.querySelector('.fb-typt');
      if (aan && !b) {
        b = el('div', 'fb-bericht fb-faro fb-typt');
        var d = el('div', 'fb-bel fb-stippen');
        d.appendChild(el('span')); d.appendChild(el('span')); d.appendChild(el('span'));
        b.appendChild(d);
        draad.appendChild(b);
        draad.scrollTop = draad.scrollHeight;
      } else if (!aan && b) {
        b.remove();
      }
    }

    async function vraag(tekst) {
      bezig = true;
      veld.disabled = true;
      verstuur.disabled = true;
      typt(true);
      try {
        var r = await fetch(EINDPUNT, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ bericht: tekst, historie: historie.slice(-MAX_BEURTEN), taal: taal() }),
        });
        var data = await r.json().catch(function () { return {}; });
        typt(false);
        var antwoord = data.antwoord || t.fout;
        zeg('assistant', antwoord, data.cta);
        historie.push({ rol: 'assistant', tekst: antwoord });
      } catch (e) {
        typt(false);
        zeg('assistant', t.fout);
      } finally {
        bezig = false;
        veld.disabled = false;
        verstuur.disabled = false;
        if (open) veld.focus();
      }
    }

    form.addEventListener('submit', function (e) {
      e.preventDefault();
      if (bezig) return;
      var tekst = veld.value.trim().slice(0, MAX_TEKENS);
      if (!tekst) return;
      if (historie.length >= MAX_BEURTEN * 2) { zeg('assistant', t.op); return; }
      veld.value = '';
      zeg('user', tekst);
      historie.push({ rol: 'user', tekst: tekst });
      vraag(tekst);
    });

    /* ── Openen en sluiten ──────────────────────────────────────────────── */
    function zetOpen(aan) {
      open = aan;
      paneel.hidden = !aan;
      knop.setAttribute('aria-expanded', aan ? 'true' : 'false');
      knop.classList.toggle('fb-knop-actief', aan);
      /* De rondlopende gids zwijgt zolang dit venster openstaat. Twee
         pratende Faro's tegelijk is er één te veel. */
      document.documentElement.classList.toggle('fb-open', aan);
      if (aan) {
        if (!draad.children.length) zeg('assistant', t.welkom);
        if (!rustig) setTimeout(function () { veld.focus(); }, 120);
        else veld.focus();
      } else {
        knop.focus();
      }
    }

    knop.addEventListener('click', function () { zetOpen(!open); });
    dicht.addEventListener('click', function () { zetOpen(false); });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && open) zetOpen(false);
    });

    /* Tab mag niet achter het venster verdwijnen zolang het open is. */
    paneel.addEventListener('keydown', function (e) {
      if (e.key !== 'Tab') return;
      var kan = paneel.querySelectorAll('button, input, a[href]');
      if (!kan.length) return;
      var eerste = kan[0], laatste = kan[kan.length - 1];
      if (e.shiftKey && document.activeElement === eerste) { e.preventDefault(); laatste.focus(); }
      else if (!e.shiftKey && document.activeElement === laatste) { e.preventDefault(); eerste.focus(); }
    });
  }

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', init);
  else init();
})();
