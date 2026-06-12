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
   TILT — telefoonmockup kantelt 3D mee met de cursor
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

  const observer = new IntersectionObserver(
    entries => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.12, rootMargin: '0px 0px -40px 0px' }
  );

  targets.forEach(el => observer.observe(el));
}

/* ============================================================
   WHATSAPP CHAT ANIMATION
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

      // Show typing before "sent" messages
      if (msg.classList.contains('sent') && typing) {
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
   BOOKING — eigen kalender in huisstijl, Calendly enkel als
   modal voor het kiezen van een tijdstip
   ============================================================ */
function initBooking() {
  const cal = document.querySelector('.cal[data-calendly]');
  if (!cal) return;

  const base = cal.dataset.calendly;
  const monthLabel = cal.querySelector('.cal-month');
  const datesGrid = cal.querySelector('.cal-dates');
  const prevBtn = cal.querySelector('.cal-prev');
  const nextBtn = cal.querySelector('.cal-next');

  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const firstOfThisMonth = new Date(today.getFullYear(), today.getMonth(), 1);
  let view = new Date(firstOfThisMonth);
  const maxView = new Date(today.getFullYear(), today.getMonth() + 3, 1);

  const fmtMonth = new Intl.DateTimeFormat('nl-BE', { month: 'long', year: 'numeric' });
  const fmtDay = new Intl.DateTimeFormat('nl-BE', { weekday: 'long', day: 'numeric', month: 'long' });
  const pad = n => String(n).padStart(2, '0');

  // Paneel voor de eigen tijdslot-kiezer
  const timesPanel = document.createElement('div');
  timesPanel.className = 'cal-times';
  timesPanel.hidden = true;
  cal.appendChild(timesPanel);

  function render() {
    monthLabel.textContent = fmtMonth.format(view);
    datesGrid.innerHTML = '';
    const year = view.getFullYear();
    const month = view.getMonth();
    const firstWeekday = (new Date(year, month, 1).getDay() + 6) % 7; // maandag = 0
    const daysInMonth = new Date(year, month + 1, 0).getDate();

    for (let i = 0; i < firstWeekday; i++) {
      datesGrid.appendChild(document.createElement('span'));
    }
    for (let d = 1; d <= daysInMonth; d++) {
      const date = new Date(year, month, d);
      const cell = document.createElement('button');
      cell.type = 'button';
      cell.className = 'cal-date';
      cell.textContent = d;
      const isPast = date < today;
      const isWeekend = date.getDay() === 0 || date.getDay() === 6;
      if (isPast || isWeekend) {
        cell.disabled = true;
      } else {
        cell.setAttribute('aria-label', fmtDay.format(date));
        cell.addEventListener('click', () => showTimes(date, cell));
      }
      if (date.getTime() === today.getTime()) cell.classList.add('today');
      datesGrid.appendChild(cell);
    }
    prevBtn.disabled = view.getTime() <= firstOfThisMonth.getTime();
    nextBtn.disabled = view.getTime() >= maxView.getTime();
  }

  prevBtn.addEventListener('click', () => {
    view = new Date(view.getFullYear(), view.getMonth() - 1, 1);
    render();
  });
  nextBtn.addEventListener('click', () => {
    view = new Date(view.getFullYear(), view.getMonth() + 1, 1);
    render();
  });

  function showTimes(date, cell) {
    datesGrid.querySelectorAll('.cal-date.selected').forEach(c => c.classList.remove('selected'));
    cell.classList.add('selected');

    timesPanel.hidden = false;
    timesPanel.innerHTML = '';
    const title = document.createElement('p');
    title.className = 'cal-times-title';
    title.textContent = 'Kies een uur — ' + fmtDay.format(date);
    const grid = document.createElement('div');
    grid.className = 'times-grid';
    for (let h = 9; h <= 16; h++) {
      ['00', '30'].forEach(m => {
        const time = pad(h) + ':' + m;
        const chip = document.createElement('button');
        chip.type = 'button';
        chip.className = 'time-chip';
        chip.textContent = time;
        chip.addEventListener('click', () => openConfirm(date, time));
        grid.appendChild(chip);
      });
    }
    const note = document.createElement('p');
    note.className = 'cal-times-note';
    note.textContent = 'Daarna bevestig je enkel nog je naam en e-mailadres.';
    timesPanel.append(title, grid, note);
    timesPanel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
  }

  function openConfirm(date, time) {
    // Directe slot-URL: Calendly toont dan enkel het bevestigingsformulier
    const d = new Date(date);
    const parts = time.split(':');
    d.setHours(+parts[0], +parts[1], 0, 0);
    const off = -d.getTimezoneOffset();
    const sign = off >= 0 ? '+' : '-';
    const iso = d.getFullYear() + '-' + pad(d.getMonth() + 1) + '-' + pad(d.getDate()) +
      'T' + time + ':00' + sign + pad(Math.floor(Math.abs(off) / 60)) + ':' + pad(Math.abs(off) % 60);
    const params = new URLSearchParams({
      embed_domain: location.hostname || 'localhost',
      embed_type: 'Inline',
      hide_event_type_details: '1',
      hide_gdpr_banner: '1'
    });
    const slotUrl = base + '/' + encodeURIComponent(iso) + '?' + params.toString();
    openModal(slotUrl, fmtDay.format(date) + ' · ' + time + ' — bevestig je gegevens');
  }

  function openModal(src, titleText) {
    const overlay = document.createElement('div');
    overlay.className = 'cal-modal';
    overlay.innerHTML =
      '<div class="cal-modal-box" role="dialog" aria-modal="true">' +
        '<div class="cal-modal-head">' +
          '<span class="cal-modal-title"></span>' +
          '<button type="button" class="cal-modal-close" aria-label="Sluiten">✕</button>' +
        '</div>' +
        '<div class="cal-modal-body">' +
          '<div class="booking-loading"><span class="booking-spinner" aria-hidden="true"></span>Formulier laden…</div>' +
        '</div>' +
      '</div>';
    overlay.querySelector('.cal-modal-title').textContent = titleText;
    document.body.appendChild(overlay);
    document.body.style.overflow = 'hidden';

    const iframe = document.createElement('iframe');
    iframe.src = src;
    iframe.title = 'Bevestig je afspraak';
    iframe.addEventListener('load', () => {
      const loader = overlay.querySelector('.booking-loading');
      if (loader) loader.classList.add('hidden');
    });
    overlay.querySelector('.cal-modal-body').appendChild(iframe);

    function close() {
      overlay.remove();
      document.body.style.overflow = '';
      document.removeEventListener('keydown', onKey);
    }
    function onKey(e) {
      if (e.key === 'Escape') close();
    }
    overlay.addEventListener('click', e => { if (e.target === overlay) close(); });
    overlay.querySelector('.cal-modal-close').addEventListener('click', close);
    document.addEventListener('keydown', onKey);
    requestAnimationFrame(() => overlay.classList.add('open'));
  }

  render();
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
  const result = calc.querySelector('.calc-result-value');
  if (!leadsInput || !valueInput || !convInput || !result) return;

  const fmt = new Intl.NumberFormat('nl-BE', {
    style: 'currency',
    currency: 'EUR',
    maximumFractionDigits: 0
  });

  function clamp(val, min, max) {
    return Math.min(Math.max(val, min), max);
  }

  function update() {
    const leads = clamp(parseFloat(leadsInput.value) || 0, 0, 100000);
    const value = clamp(parseFloat(valueInput.value) || 0, 0, 10000000);
    const conv = clamp(parseFloat(convInput.value) || 0, 0, 100);
    // Aanname: zonder opvolging binnen het uur verdampt ±50% van het conversiepotentieel
    const lost = leads * (conv / 100) * value * 0.5;
    result.textContent = fmt.format(Math.round(lost));
  }

  [leadsInput, valueInput, convInput].forEach(input => {
    input.addEventListener('input', update);
  });
  update();
}

/* ============================================================
   CONTACT FORM — prevent default, show feedback
   ============================================================ */
function initContactForm() {
  const form = document.querySelector('.helvaro-form');
  if (!form) return;

  form.addEventListener('submit', e => {
    e.preventDefault();
    const btn = form.querySelector('.form-submit');
    if (!btn) return;
    btn.textContent = 'Verzonden ✓';
    btn.disabled = true;
    btn.style.opacity = '0.7';
    // Reset after 3 seconds
    setTimeout(() => {
      btn.textContent = 'Verzend';
      btn.disabled = false;
      btn.style.opacity = '';
      form.reset();
    }, 3000);
  });
}
