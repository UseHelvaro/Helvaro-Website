/* ============================================================
   HELVARO — Shared JavaScript
   ============================================================ */

document.addEventListener('DOMContentLoaded', () => {
  initNav();
  initFAQ();
  initReveal();
  initWhatsApp();
  initSmoothScroll();
  initContactForm();
  initScrollProgress();
  initCountUp();
  initSpotlight();
  initHeroParallax();
  initCalculator();
  initBooking();
  initDemoForm();
  initTheme();
  initSignature();
  initWordAnim();
  initMagnetic();
  initTilt();
  initCursor();
  initWatermarkParallax();
});

/* ============================================================
   WORD ANIM — hero-titel verschijnt woord voor woord
   ============================================================ */
function initWordAnim() {
  const title = document.querySelector('.hero-title');
  if (!title || window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  let i = 0;
  function wrapWords(node) {
    Array.from(node.childNodes).forEach(child => {
      if (child.nodeType === 3) {
        const frag = document.createDocumentFragment();
        child.textContent.split(/(\s+)/).forEach(part => {
          if (!part) return;
          if (/^\s+$/.test(part)) {
            frag.appendChild(document.createTextNode(part));
            return;
          }
          const span = document.createElement('span');
          span.className = 'w';
          span.style.animationDelay = (i++ * 70) + 'ms';
          span.textContent = part;
          frag.appendChild(span);
        });
        node.replaceChild(frag, child);
      } else if (child.nodeType === 1) {
        wrapWords(child);
      }
    });
  }
  wrapWords(title);
}

/* ============================================================
   MAGNETIC — knoppen trekken licht naar de cursor
   ============================================================ */
function initMagnetic() {
  if (window.matchMedia('(hover: none)').matches) return;
  document.querySelectorAll('.btn').forEach(btn => {
    btn.addEventListener('pointermove', e => {
      const r = btn.getBoundingClientRect();
      const dx = (e.clientX - r.left - r.width / 2) / r.width;
      const dy = (e.clientY - r.top - r.height / 2) / r.height;
      btn.style.transform = `translate(${(dx * 8).toFixed(1)}px, ${(dy * 6).toFixed(1)}px)`;
    });
    btn.addEventListener('pointerleave', () => {
      btn.style.transform = '';
    });
  });
}



/* ============================================================
   CURSOR — eigen cursor-dot + ring (desktop)
   ============================================================ */
function initCursor() {
  if (window.matchMedia('(hover: none)').matches) return;
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  const dot = document.createElement('div');
  dot.className = 'cursor-dot';
  const ring = document.createElement('div');
  ring.className = 'cursor-ring';
  dot.setAttribute('aria-hidden', 'true');
  ring.setAttribute('aria-hidden', 'true');
  document.body.append(dot, ring);

  let mx = -100, my = -100, rx = -100, ry = -100;
  window.addEventListener('pointermove', e => {
    mx = e.clientX;
    my = e.clientY;
    dot.style.transform = `translate(${mx}px, ${my}px)`;
  }, { passive: true });

  (function loop() {
    rx += (mx - rx) * 0.16;
    ry += (my - ry) * 0.16;
    ring.style.transform = `translate(${rx.toFixed(1)}px, ${ry.toFixed(1)}px)`;
    requestAnimationFrame(loop);
  })();

  document.addEventListener('pointerover', e => {
    ring.classList.toggle('on-link', !!e.target.closest('a, button'));
  });
}

/* ============================================================
   WATERMARK PARALLAX — sectienummers bewegen traag mee
   ============================================================ */
function initWatermarkParallax() {
  const headers = document.querySelectorAll('.section-header[data-num]');
  if (!headers.length) return;
  let ticking = false;
  function update() {
    ticking = false;
    const vh = window.innerHeight;
    headers.forEach(h => {
      const r = h.getBoundingClientRect();
      if (r.bottom < -200 || r.top > vh + 200) return;
      h.style.setProperty('--wm-shift', ((r.top - vh / 2) * 0.12).toFixed(1) + 'px');
    });
  }
  window.addEventListener('scroll', () => {
    if (!ticking) {
      ticking = true;
      requestAnimationFrame(update);
    }
  }, { passive: true });
  update();
}

/* ============================================================
   SIGNATURE — korrel, wordmark en sectienummers (alle pagina's)
   ============================================================ */
function initSignature() {
  // Filmkorrel-overlay
  const grain = document.createElement('div');
  grain.className = 'grain';
  grain.setAttribute('aria-hidden', 'true');
  document.body.appendChild(grain);

  // Footer-wordmark
  const footerInner = document.querySelector('.footer-inner');
  const footerBottom = document.querySelector('.footer-bottom');
  if (footerInner && footerBottom) {
    const wm = document.createElement('div');
    wm.className = 'footer-wordmark';
    wm.setAttribute('aria-hidden', 'true');
    wm.textContent = 'HELVARO';
    footerInner.insertBefore(wm, footerBottom);
  }

  // Sectienummer-watermerken (uit labels als "01 — ...")
  document.querySelectorAll('.section-label').forEach(label => {
    const m = label.textContent.trim().match(/^(\d{2})/);
    const header = label.closest('.section-header');
    if (m && header) header.setAttribute('data-num', m[1]);
  });
}

/* ============================================================
   NAV — sticky scroll + hamburger
   ============================================================ */
function initNav() {
  const nav = document.querySelector('.nav');
  const hamburger = document.querySelector('.nav-hamburger');
  const mobileMenu = document.querySelector('.nav-mobile');

  if (!nav) return;

  // Scroll class
  function onScroll() {
    nav.classList.toggle('scrolled', window.scrollY > 20);
  }
  window.addEventListener('scroll', onScroll, { passive: true });
  onScroll();

  // Hamburger toggle
  if (hamburger && mobileMenu) {
    hamburger.addEventListener('click', () => {
      const isOpen = hamburger.classList.toggle('open');
      hamburger.setAttribute('aria-expanded', String(isOpen));
      if (isOpen) {
        mobileMenu.classList.add('open');
        document.body.style.overflow = 'hidden';
      } else {
        mobileMenu.classList.remove('open');
        document.body.style.overflow = '';
      }
    });

    // Close on link click
    mobileMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        hamburger.classList.remove('open');
        mobileMenu.classList.remove('open');
        document.body.style.overflow = '';
      });
    });

    // Close on backdrop click
    document.addEventListener('click', e => {
      if (
        mobileMenu.classList.contains('open') &&
        !mobileMenu.contains(e.target) &&
        !hamburger.contains(e.target)
      ) {
        hamburger.classList.remove('open');
        mobileMenu.classList.remove('open');
        document.body.style.overflow = '';
      }
    });
  }
}

/* ============================================================
   FAQ — accordion
   ============================================================ */
function initFAQ() {
  const items = document.querySelectorAll('.faq-item');
  items.forEach(item => {
    const question = item.querySelector('.faq-question');
    if (!question) return;
    question.addEventListener('click', () => {
      const isOpen = item.classList.contains('open');
      // Close all
      items.forEach(i => {
        i.classList.remove('open');
        const q = i.querySelector('.faq-question');
        if (q) q.setAttribute('aria-expanded', 'false');
      });
      // Toggle current
      if (!isOpen) {
        item.classList.add('open');
        question.setAttribute('aria-expanded', 'true');
      }
    });
  });
}

/* ============================================================
   SCROLL REVEAL — IntersectionObserver
   ============================================================ */
function initReveal() {
  const targets = document.querySelectorAll('.reveal, .reveal-scale');
  if (!targets.length) return;

  const show = el => el.classList.add('visible');

  // Fail-safe: zonder IntersectionObserver (of bij een viewport van 0px hoog,
  // zoals in sommige previews en headless browsers) tonen we alles meteen.
  // Content mag nooit permanent onzichtbaar blijven door een animatie.
  if (!('IntersectionObserver' in window) || !window.innerHeight) {
    targets.forEach(show);
    return;
  }

  const observer = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          show(entry.target);
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.12, rootMargin: '0px 0px -40px 0px' }
  );

  targets.forEach(el => observer.observe(el));

  // Vangnet: wat na 3 seconden nog steeds verborgen is, tonen we alsnog.
  // Beschermt tegen randgevallen waarin de observer nooit afvuurt.
  window.setTimeout(() => {
    targets.forEach(el => {
      if (!el.classList.contains('visible')) show(el);
    });
  }, 3000);
}



/* ============================================================
   SMOOTH SCROLL — anchor links
   ============================================================ */
function initSmoothScroll() {
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', e => {
      const id = anchor.getAttribute('href').slice(1);
      if (!id) return;
      const target = document.getElementById(id);
      if (!target) return;
      e.preventDefault();
      const navH = parseInt(
        getComputedStyle(document.documentElement).getPropertyValue('--nav-h') || '70'
      );
      const top = target.getBoundingClientRect().top + window.scrollY - navH - 16;
      window.scrollTo({ top, behavior: 'smooth' });
    });
  });
}

/* ============================================================
   SCROLL PROGRESS BAR
   ============================================================ */
function initScrollProgress() {
  const bar = document.createElement('div');
  bar.className = 'scroll-progress';
  bar.setAttribute('aria-hidden', 'true');
  document.body.appendChild(bar);

  function update() {
    const max = document.documentElement.scrollHeight - window.innerHeight;
    bar.style.width = (max > 0 ? (window.scrollY / max) * 100 : 0) + '%';
  }
  window.addEventListener('scroll', update, { passive: true });
  window.addEventListener('resize', update, { passive: true });
  update();
}

/* ============================================================
   COUNT-UP STATS — animate numbers when scrolled into view
   ============================================================ */
function initCountUp() {
  const els = document.querySelectorAll('[data-target]');
  if (!els.length) return;

  const observer = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        observer.unobserve(entry.target);
        const el = entry.target;
        const target = parseFloat(el.dataset.target);
        const prefix = el.dataset.prefix || '';
        const suffix = el.dataset.suffix || '';
        const duration = 1300;
        const start = performance.now();

        function tick(now) {
          const p = Math.min((now - start) / duration, 1);
          const eased = 1 - Math.pow(1 - p, 3);
          el.textContent = prefix + Math.round(target * eased) + suffix;
          if (p < 1) requestAnimationFrame(tick);
        }
        requestAnimationFrame(tick);
      });
    },
    { threshold: 0.5 }
  );

  els.forEach(el => observer.observe(el));
}

/* ============================================================
   SPOTLIGHT — cursor-tracking glow on cards
   ============================================================ */
function initSpotlight() {
  if (window.matchMedia('(hover: none)').matches) return;
  const cards = document.querySelectorAll(
    '.feature-card, .proof-card, .pricing-card, .process-step, .comp-col, .form-card, .booking-placeholder'
  );
  cards.forEach(card => {
    card.classList.add('spot');
    card.addEventListener('pointermove', e => {
      const r = card.getBoundingClientRect();
      card.style.setProperty('--mx', (e.clientX - r.left) + 'px');
      card.style.setProperty('--my', (e.clientY - r.top) + 'px');
    });
  });
}

/* ============================================================
   HERO PARALLAX — glows follow the cursor subtly
   ============================================================ */
function initHeroParallax() {
  if (window.matchMedia('(hover: none)').matches) return;
  const hero = document.querySelector('.hero');
  if (!hero) return;
  const g1 = hero.querySelector('.hero-glow');
  const g2 = hero.querySelector('.hero-glow-2');
  if (!g1) return;

  hero.addEventListener('pointermove', e => {
    const r = hero.getBoundingClientRect();
    const x = (e.clientX - r.left) / r.width - 0.5;
    const y = (e.clientY - r.top) / r.height - 0.5;
    g1.style.transform = `translate(${x * 30}px, ${y * 30}px)`;
    if (g2) g2.style.transform = `translate(${x * -22}px, ${y * -22}px)`;
  });
}

/* ============================================================
   BOEKINGSAGENDA
   Toont de boekingspagina uit Google Agenda in de pagina zelf.
   Die haalt de vrije momenten rechtstreeks uit admins@helvaro.pro,
   dus wat een bezoeker ziet is altijd echt boekbaar en dubbele
   boekingen kunnen niet.
   Ander schema koppelen: pas data-booking aan in meeting.html.
   ============================================================ */
function initBooking() {
  const houder = document.querySelector('.booking-embed[data-booking]');
  if (!houder) return;

  const loader = houder.querySelector('.booking-loading');
  const frame = document.createElement('iframe');
  frame.src = houder.dataset.booking + '?gv=true';
  frame.title = 'Kies een moment voor je lead-audit';
  frame.loading = 'lazy';
  frame.addEventListener('load', () => {
    if (loader) loader.classList.add('hidden');
  });
  houder.appendChild(frame);
}

/* ============================================================
   ROI CALCULATOR — live berekening met eigen cijfers
   ============================================================ */
function initCalculator() {
  const calc = document.querySelector('.calc-card');
  if (!calc) return;

  const leadsInput = calc.querySelector('#calc-leads');
  const valueInput = calc.querySelector('#calc-value');
  const convInput = calc.querySelector('#calc-conv');
  const missInput = calc.querySelector('#calc-miss');
  const result = calc.querySelector('.calc-result-value');
  const outLeads = calc.querySelector('#calc-out-leads');
  const outClients = calc.querySelector('#calc-out-clients');
  if (!leadsInput || !valueInput || !convInput || !result) return;

  const fmt = new Intl.NumberFormat('nl-BE', {
    style: 'currency',
    currency: 'EUR',
    maximumFractionDigits: 0
  });
  const num = new Intl.NumberFormat('nl-BE', { maximumFractionDigits: 0 });

  function clamp(val, min, max) {
    return Math.min(Math.max(val, min), max);
  }

  function update() {
    const leads = clamp(parseFloat(leadsInput.value) || 0, 0, 100000);
    const value = clamp(parseFloat(valueInput.value) || 0, 0, 10000000);
    const conv = clamp(parseFloat(convInput.value) || 0, 0, 100);
    // Percentage leads dat niet binnen het uur wordt opgevolgd (instelbaar)
    const missPct = missInput ? clamp(parseFloat(missInput.value) || 0, 0, 100) : 50;

    const missedLeads = leads * (missPct / 100);
    const missedClients = missedLeads * (conv / 100);
    const lost = missedClients * value;

    result.textContent = fmt.format(Math.round(lost));
    if (outLeads) outLeads.textContent = num.format(Math.round(missedLeads));
    if (outClients) outClients.textContent = num.format(Math.round(missedClients));
  }

  [leadsInput, valueInput, convInput, missInput].forEach(input => {
    if (input) input.addEventListener('input', update);
  });
  update();
}

/* ============================================================
   CONTACT FORM — prevent default, show feedback
   ============================================================ */
/* Teksten van het contactformulier in vijf talen */
const FORM_TEKST = {
  nl: { bezig:'Versturen…', gelukt:'Verzonden ✓', fout:'Versturen mislukt',
        leeg:'Vul alle velden in.', email:'Vul een geldig e-mailadres in.',
        gelukt_uitleg:'Bedankt, we nemen binnen 24 uur contact op.',
        fout_uitleg:'Er ging iets mis. Mail ons rechtstreeks op hello@helvaro.pro.' ,
        faro_idle:'Vul je gegevens in, dan zorg ik dat je bericht bij de juiste persoon komt.',
        faro_denkt:'Dat ziet er compleet uit. Klik op verzenden en ik geef het door.',
        faro_klaar:'Verzonden. Iemand van ons leest het en komt bij je terug.' },
  fr: { bezig:'Envoi…', gelukt:'Envoyé ✓', fout:'Échec de l\'envoi',
        leeg:'Veuillez remplir tous les champs.', email:'Saisissez une adresse e-mail valide.',
        gelukt_uitleg:'Merci, nous vous recontactons sous 24 heures.',
        fout_uitleg:'Une erreur est survenue. Écrivez-nous à hello@helvaro.pro.' ,
        faro_idle:'Remplissez vos coordonnées et je veille à ce que votre message arrive au bon endroit.',
        faro_denkt:'Cela a l\'air complet. Cliquez sur envoyer et je le transmets.',
        faro_klaar:'Envoyé. Quelqu\'un de chez nous le lit et vous recontacte.' },
  en: { bezig:'Sending…', gelukt:'Sent ✓', fout:'Sending failed',
        leeg:'Please fill in every field.', email:'Enter a valid email address.',
        gelukt_uitleg:'Thanks, we will get back to you within 24 hours.',
        fout_uitleg:'Something went wrong. Email us directly at hello@helvaro.pro.' ,
        faro_idle:'Fill in your details and I\'ll make sure your message reaches the right person.',
        faro_denkt:'That looks complete. Hit send and I\'ll pass it on.',
        faro_klaar:'Sent. Someone here will read it and get back to you.' },
  de: { bezig:'Wird gesendet…', gelukt:'Gesendet ✓', fout:'Senden fehlgeschlagen',
        leeg:'Bitte füllen Sie alle Felder aus.', email:'Geben Sie eine gültige E-Mail-Adresse ein.',
        gelukt_uitleg:'Danke, wir melden uns innerhalb von 24 Stunden.',
        fout_uitleg:'Etwas ist schiefgelaufen. Schreiben Sie an hello@helvaro.pro.' ,
        faro_idle:'Tragen Sie Ihre Daten ein, dann sorge ich dafür, dass Ihre Nachricht ankommt.',
        faro_denkt:'Das sieht vollständig aus. Klicken Sie auf Senden, ich gebe es weiter.',
        faro_klaar:'Gesendet. Jemand von uns liest es und meldet sich bei Ihnen.' },
  es: { bezig:'Enviando…', gelukt:'Enviado ✓', fout:'Error al enviar',
        leeg:'Rellena todos los campos.', email:'Introduce un correo válido.',
        gelukt_uitleg:'Gracias, te contactamos en menos de 24 horas.',
        fout_uitleg:'Algo salió mal. Escríbenos a hello@helvaro.pro.' ,
        faro_idle:'Rellena tus datos y me aseguro de que tu mensaje llegue a la persona indicada.',
        faro_denkt:'Parece completo. Pulsa enviar y yo lo hago llegar.',
        faro_klaar:'Enviado. Alguien de nuestro equipo lo leerá y te responderá.' }
};

/* ============================================================
   CONTACTFORMULIER
   Verstuurt naar het adres in data-endpoint. Staat dat leeg, dan
   opent het de mailclient van de bezoeker met alles ingevuld, zodat
   een bericht nooit verloren gaat.
   Een endpoint instellen: data-endpoint="https://..." op het formulier.
   ============================================================ */
function initContactForm() {
  const form = document.querySelector('.helvaro-form');
  if (!form) return;

  const btn = form.querySelector('.form-submit');
  const btnTekst = btn ? btn.textContent : '';
  let melding = form.querySelector('.form-status');
  if (!melding) {
    melding = document.createElement('p');
    melding.className = 'form-status';
    melding.setAttribute('role', 'status');
    melding.setAttribute('aria-live', 'polite');
    form.appendChild(melding);
  }

  function taal() {
    const l = (document.documentElement.lang || 'nl').slice(0, 2);
    return FORM_TEKST[l] || FORM_TEKST.nl;
  }

  /* ── Faro bij dit formulier ────────────────────────────────────────
     Zelfde opzet als op de aanmeldpagina: zijn houding IS de statusregel,
     en elke houding zegt hetzelfde in woorden in de regel ernaast. Een
     houding is geen boodschap -- een schermlezer ziet hem niet, en wie
     kleurenblind is leest hem ook niet aan de rand af. */
  const faroVak  = form.querySelector('.signup-faro');
  const faroImg  = document.getElementById('contactFaro');
  const faroLine = document.getElementById('contactFaroLine');
  const FARO_IMG = {
    idle:  'assets/faro/falcon-idle.webp',
    denkt: 'assets/faro/falcon-thinking.webp',
    bezig: 'assets/faro/falcon-generating.webp',
    fout:  'assets/faro/falcon-error.webp',
    klaar: 'assets/faro/falcon-success.webp'
  };
  function zetFaro(toestand, tekst) {
    if (!faroVak || !faroImg || !faroLine) return;
    faroVak.setAttribute('data-faro-state', toestand);
    faroImg.src = FARO_IMG[toestand] || FARO_IMG.idle;
    const tt = taal();
    faroLine.textContent = tekst || tt['faro_' + toestand] || tt.faro_idle || '';
  }

  function toon(soort, tekst) {
    melding.textContent = tekst;
    melding.className = 'form-status ' + soort;
  }

  function herstel() {
    if (!btn) return;
    btn.textContent = btnTekst;
    btn.disabled = false;
  }

  /* De beginregel staat in het Nederlands in de HTML, als terugval wanneer dit
     script niet laadt. Draait het wel, dan hoort hij de taal van de bezoeker te
     volgen -- de vertaalmachine van de site loopt eenmalig door de DOM en kent
     deze zin niet.

     Precies dezelfde val als in js/signup.js, en ik liep er alsnog in: bij het
     naleven stond er een Nederlandse beginregel op een Engelse pagina, terwijl
     alle andere toestanden wel klopten. Kijken naar het lang-attribuut lost het
     op EN doet meteen het goede wanneer iemand halverwege van taal wisselt met
     de kiezer in de navigatie. */
  function faroBeginregel() {
    const vak = form.querySelector('.signup-faro');
    // Niet overschrijven wanneer Faro iets specifiekers zegt (een fout, of
    // 'bezig') -- alleen de rusttoestand volgt de taal.
    if (!vak || vak.getAttribute('data-faro-state') !== 'idle') return;
    zetFaro('idle');
  }
  faroBeginregel();
  if (window.MutationObserver) {
    new MutationObserver(faroBeginregel).observe(document.documentElement, {
      attributes: true, attributeFilter: ['lang']
    });
  }

  /* Reageren terwijl je typt, niet pas bij verzenden. Zodra alles ingevuld is
     gaat hij van rust naar aandacht: dat is het moment waarop hij iets kan
     betekenen, en het maakt zichtbaar dat het formulier compleet is voordat je
     op de knop drukt. */
  form.addEventListener('input', () => {
    const vak = form.querySelector('.signup-faro');
    if (vak && vak.getAttribute('data-faro-state') === 'bezig') return;
    const velden = ['naam', 'email', 'bedrijf', 'bericht']
      .map(n => (form[n] ? String(form[n].value || '').trim() : ''));
    zetFaro(velden.every(Boolean) ? 'denkt' : 'idle');
  });

  form.addEventListener('submit', async e => {
    e.preventDefault();
    const t = taal();

    const naam = (form.naam ? form.naam.value : '').trim();
    const email = (form.email ? form.email.value : '').trim();
    const bedrijf = (form.bedrijf ? form.bedrijf.value : '').trim();
    const bericht = (form.bericht ? form.bericht.value : '').trim();

    if (!naam || !email || !bedrijf || !bericht) {
      toon('error', t.leeg);
      zetFaro('fout', t.leeg);
      return;
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(email)) {
      toon('error', t.email);
      zetFaro('fout', t.email);
      if (form.email) form.email.focus();
      return;
    }

    const endpoint = (form.dataset.endpoint || '').trim();

    if (!endpoint) {
      // Geen endpoint ingesteld: openen in de mailclient, zo raakt niets kwijt
      const onderwerp = 'Lead-analyse aanvraag — ' + bedrijf;
      const body = naam + ' (' + bedrijf + ')\n' + email + '\n\n' + bericht;
      window.location.href = 'mailto:hello@helvaro.pro?subject=' +
        encodeURIComponent(onderwerp) + '&body=' + encodeURIComponent(body);
      toon('ok', t.gelukt_uitleg);
      /* Bewust GEEN 'klaar': er is niets naar ons verstuurd, alleen het
         mailvenster van de bezoeker geopend. Faro juichen laten om iets dat
         nog moet gebeuren is precies het soort onwaarheid dat de rest van wat
         hij zegt verdacht maakt. */
      zetFaro('bezig');
      return;
    }

    if (btn) { btn.textContent = t.bezig; btn.disabled = true; }
    zetFaro('bezig');
    toon('', '');
    try {
      const res = await fetch(endpoint, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
        body: JSON.stringify({ naam, email, bedrijf, bericht })
      });
      if (!res.ok) throw new Error('status ' + res.status);
      if (btn) btn.textContent = t.gelukt;
      toon('ok', t.gelukt_uitleg);
      zetFaro('klaar');
      form.reset();
      setTimeout(herstel, 4000);
    } catch (err) {
      if (btn) btn.textContent = t.fout;
      toon('error', t.fout_uitleg);
      zetFaro('fout', t.fout_uitleg);
      setTimeout(herstel, 4000);
    }
  });
}

/* ============================================================
   DEMO-FORMULIER — bezoeker vult zijn nummer in en start
   meteen een demo-gesprek met de Helvaro-AI op WhatsApp.

   INSTELLEN: zet het WhatsApp-demonummer van Helvaro in het
   data-demo-number attribuut van .demo-form in index.html,
   in internationaal formaat zonder + of spaties.
   Bijvoorbeeld: data-demo-number="32470123456"
   Zolang het leeg is, valt de knop terug op de boekingspagina.
   ============================================================ */
/* Teksten van het demo-formulier in de vijf talen */
const FOUTMELDING = {
  nl: 'Vul je WhatsApp-nummer in, inclusief landcode (bijvoorbeeld +32).',
  fr: 'Saisissez votre num\u00e9ro WhatsApp avec l\'indicatif pays (par exemple +32).',
  en: 'Enter your WhatsApp number including the country code (for example +32).',
  de: 'Geben Sie Ihre WhatsApp-Nummer inklusive L\u00e4ndervorwahl ein (zum Beispiel +32).',
  es: 'Introduce tu n\u00famero de WhatsApp con el prefijo del pa\u00eds (por ejemplo +32).'
};
const OPENINGSZIN = {
  nl: 'Hallo Helvaro, ik wil graag een demo-gesprek. Mijn nummer is {nummer}.',
  fr: 'Bonjour Helvaro, je souhaite une conversation de d\u00e9mo. Mon num\u00e9ro est {nummer}.',
  en: 'Hi Helvaro, I would like a demo conversation. My number is {nummer}.',
  de: 'Hallo Helvaro, ich m\u00f6chte gern ein Demo-Gespr\u00e4ch. Meine Nummer ist {nummer}.',
  es: 'Hola Helvaro, me gustar\u00eda una conversaci\u00f3n de demo. Mi n\u00famero es {nummer}.'
};

function initDemoForm() {
  const form = document.querySelector('.demo-form');
  if (!form) return;

  const input = form.querySelector('.demo-input');
  const note = form.querySelector('.demo-note');
  const noteText = note ? note.textContent : '';

  form.addEventListener('submit', e => {
    e.preventDefault();

    const raw = (input.value || '').trim();
    const digits = raw.replace(/[^\d]/g, '');
    const taal = (document.documentElement.lang || 'nl').slice(0, 2);

    // Minimaal een plausibel internationaal nummer
    if (digits.length < 8) {
      input.classList.add('invalid');
      if (note) {
        note.textContent = FOUTMELDING[taal] || FOUTMELDING.nl;
        note.classList.add('error');
      }
      input.focus();
      return;
    }

    input.classList.remove('invalid');
    if (note) {
      note.textContent = noteText;
      note.classList.remove('error');
    }

    const demoNumber = (form.dataset.demoNumber || '').replace(/[^\d]/g, '');

    if (!demoNumber) {
      // Nog geen demonummer ingesteld: stuur door naar de boekingspagina
      window.location.href = 'meeting.html#booking';
      return;
    }

    const sjabloon = OPENINGSZIN[taal] || OPENINGSZIN.nl;
    const msg = sjabloon.replace('{nummer}', raw);
    window.open(
      'https://wa.me/' + demoNumber + '?text=' + encodeURIComponent(msg),
      '_blank',
      'noopener'
    );
  });

  input.addEventListener('input', () => {
    input.classList.remove('invalid');
    if (note && note.classList.contains('error')) {
      note.textContent = noteText;
      note.classList.remove('error');
    }
  });
}


/* ============================================================
   THEMA — licht of donker, keuze blijft bewaard.
   Het thema wordt al in de <head> gezet zodat de pagina niet
   even in de verkeerde kleur flitst; hier hangen we enkel de
   knop eraan.
   ============================================================ */
function initTheme() {
  var root = document.documentElement;

  function current() {
    return root.getAttribute('data-theme') === 'dark' ? 'dark' : 'light';
  }

  function apply(theme, animate) {
    if (animate) {
      root.classList.add('theme-anim');
      window.setTimeout(function () { root.classList.remove('theme-anim'); }, 320);
    }
    root.setAttribute('data-theme', theme);
    try { localStorage.setItem('helvaro_theme', theme); } catch (e) {}
    document.querySelectorAll('.theme-toggle').forEach(function (btn) {
      btn.setAttribute('aria-pressed', theme === 'dark' ? 'true' : 'false');
    });
  }

  // Beginwaarde vastleggen (de head-code zette het attribuut al)
  apply(current(), false);

  document.querySelectorAll('.theme-toggle').forEach(function (btn) {
    btn.addEventListener('click', function () {
      apply(current() === 'dark' ? 'light' : 'dark', true);
    });
  });
}

/* ============================================================
   WHATSAPP MOCKUP — typindicator en berichten
   ============================================================ */
function initWhatsApp() {
  const chat = document.querySelector('.wa-chat');
  if (!chat) return;

  const messages = chat.querySelectorAll('.wa-msg');
  const typing = chat.querySelector('.wa-typing');
  if (!messages.length) return;

  let loopTimer = null;

  function showMessage(index) {
    if (index >= messages.length) return;
    messages[index].classList.add('visible');
    // Scroll chat to bottom
    chat.scrollTop = chat.scrollHeight;
  }

  function run() {
    // Reset
    messages.forEach(m => m.classList.remove('visible'));
    if (typing) typing.classList.remove('visible');

    // Schedule each message
    messages.forEach((msg, i) => {
      const delay = 1000 + i * 1100;

      // Typ-indicator hoort bij Mathis, dus vóór de ontvangen berichten
      if (msg.classList.contains('received') && typing) {
        setTimeout(() => {
          typing.classList.add('visible');
          chat.scrollTop = chat.scrollHeight;
        }, delay - 600);
        setTimeout(() => {
          typing.classList.remove('visible');
        }, delay - 50);
      }

      setTimeout(() => showMessage(i), delay);
    });

    // Restart loop after all messages + 3s pause
    const totalDelay = 1000 + messages.length * 1100 + 3200;
    loopTimer = setTimeout(run, totalDelay);
  }

  // Start after a short initial delay
  setTimeout(run, 600);
}

/* ============================================================
   TILT — de telefoon kantelt licht mee met de muis
   ============================================================ */
function initTilt() {
  if (window.matchMedia('(hover: none)').matches) return;
  const wrap = document.querySelector('.phone-wrap');
  const hero = document.querySelector('.hero');
  if (!wrap || !hero) return;
  hero.addEventListener('pointermove', e => {
    const r = hero.getBoundingClientRect();
    const x = (e.clientX - r.left) / r.width - 0.5;
    const y = (e.clientY - r.top) / r.height - 0.5;
    wrap.style.transform = `perspective(1000px) rotateY(${(x * 6).toFixed(2)}deg) rotateX(${(-y * 5).toFixed(2)}deg)`;
  });
  hero.addEventListener('pointerleave', () => {
    wrap.style.transform = '';
  });
}
