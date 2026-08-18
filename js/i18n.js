// Helvaro i18n — automatisch gegenereerd
(function(){
    /* Vertalingen zitten in aparte bestanden onder js/lang/. Alleen de taal
     die de bezoeker nodig heeft wordt opgehaald, dat scheelt zo'n 50 KB. */
  var TR = window.HELVARO_TR || {};
  var geladen = {};
  var huidig = 'nl';
  /* Ophogen zodra een taalbestand wijzigt, anders houdt de browser de oude versie vast. */
  var TAAL_V = '4';
  function laadTaal(lang, klaar){
    if (lang === 'nl' || TR[lang] || geladen[lang]) { klaar(); return; }
    geladen[lang] = true;
    var s = document.createElement('script');
    s.src = 'js/lang/' + lang + '.js?v=' + TAAL_V;
    s.onload = function(){ TR = window.HELVARO_TR || TR; klaar(); };
    s.onerror = function(){ klaar(); };   /* mislukt het, dan blijft Nederlands staan */
    document.head.appendChild(s);
  }

  var LABELS = {nl:'NL',fr:'FR',en:'EN',de:'DE',es:'ES'};
  var HERO = {
    nl: 'Je leads groeien. <span class="highlight">Je opvolging niet.</span>',
    fr: 'Vos leads augmentent. <span class="highlight">Votre suivi, non.</span>',
    en: 'Your leads grow. <span class="highlight">Your follow-up doesn\'t.</span>',
    de: 'Ihre Leads wachsen. <span class="highlight">Ihre Nachverfolgung nicht.</span>',
    es: 'Tus leads crecen. <span class="highlight">Tu seguimiento no.</span>'
  };
  /* Titel van het browsertabblad: die staat buiten de <body> en wordt
     dus niet door de tekstwandeling opgepikt. Apart vertalen. */
  var TITLES = {
    'Helvaro \u00b7 AI agents that follow up every lead on WhatsApp': {
      nl: 'Helvaro \u00b7 AI-agents die elke lead opvolgen via WhatsApp',
      fr: 'Helvaro \u00b7 des agents IA qui suivent chaque lead sur WhatsApp',
      de: 'Helvaro \u00b7 KI-Agents, die jeden Lead \u00fcber WhatsApp nachverfolgen',
      es: 'Helvaro \u00b7 agentes de IA que siguen cada lead por WhatsApp'
    },
    'Why Helvaro \u00b7 how AI agents follow up your leads on WhatsApp': {
      nl: 'Waarom Helvaro \u00b7 zo volgen AI-agents je leads op via WhatsApp',
      fr: 'Pourquoi Helvaro \u00b7 comment des agents IA suivent vos leads',
      de: 'Warum Helvaro \u00b7 so verfolgen KI-Agents Ihre Leads nach',
      es: 'Por qu\u00e9 Helvaro \u00b7 as\u00ed siguen tus leads los agentes de IA'
    },
    'Book a lead audit \u00b7 Helvaro': {
      nl: 'Plan een lead-audit \u00b7 Helvaro',
      fr: 'Planifier un audit de leads \u00b7 Helvaro',
      de: 'Lead-Audit planen \u00b7 Helvaro',
      es: 'Agenda una auditor\u00eda de leads \u00b7 Helvaro'
    },
    'Contact \u00b7 Helvaro': {
      nl: 'Contact \u00b7 Helvaro', fr: 'Contact \u00b7 Helvaro',
      de: 'Kontakt \u00b7 Helvaro', es: 'Contacto \u00b7 Helvaro'
    },
    'Privacy policy \u00b7 Helvaro': {
      nl: 'Privacybeleid \u00b7 Helvaro',
      fr: 'Politique de confidentialit\u00e9 \u00b7 Helvaro',
      de: 'Datenschutzerkl\u00e4rung \u00b7 Helvaro',
      es: 'Pol\u00edtica de privacidad \u00b7 Helvaro'
    }
  };
  var baseTitle = document.title;
  function applyTitle(lang){
    var set = TITLES[baseTitle];
    document.title = (lang === 'en' || !set || !set[lang]) ? baseTitle : set[lang];
  }

  /* Zinnen met opmaak erin: die splitsen in losse tekstknopen, waardoor
     alleen de vetgedrukte stukken zouden vertalen. Daarom hier als geheel. */
  var HTML_BLOKKEN = {
    heroSub: {
      nl: 'Agents die je <strong>volgende aanwerving overbodig maken</strong>. Ze staan 24/7 op je WhatsApp, kwalificeren elke lead en boeken <strong>alleen wie het waard is</strong> in je agenda.',
      fr: 'Des agents qui rendent votre <strong>prochaine embauche superflue</strong>. Ils sont 24/7 sur votre WhatsApp, qualifient chaque lead et ne r\u00e9servent <strong>que ceux qui en valent la peine</strong> dans votre agenda.',
      en: 'Agents that make your <strong>next hire irrelevant</strong>. They sit on your WhatsApp 24/7, qualify every lead and book <strong>only those worth your time</strong> into your calendar.',
      de: 'Agents, die Ihre <strong>n\u00e4chste Einstellung \u00fcberfl\u00fcssig machen</strong>. Sie sind 24/7 auf Ihrem WhatsApp, qualifizieren jeden Lead und buchen <strong>nur wer es wert ist</strong> in Ihren Kalender.',
      es: 'Agentes que hacen que tu <strong>pr\u00f3xima contrataci\u00f3n sea innecesaria</strong>. Est\u00e1n 24/7 en tu WhatsApp, cualifican cada lead y agendan <strong>solo a quien vale la pena</strong>.'
    }
  };
  function applyHtmlBlokken(lang){
    document.querySelectorAll('[data-i18n-html]').forEach(function(el){
      var set = HTML_BLOKKEN[el.getAttribute('data-i18n-html')];
      if (set && set[lang]) el.innerHTML = set[lang];
    });
  }

  var heroEl = null, heroTouched = false;
  function applyHero(lang){
    if(!heroEl) return;
    if(lang==='nl'){ if(heroTouched){ heroEl.innerHTML = HERO.nl; heroTouched = false; } }
    else { heroEl.innerHTML = HERO[lang] || HERO.nl; heroTouched = true; }
  }
  var norm = function(s){ return s.replace(/\s+/g,' ').trim(); };
  var nodes = [];
  function collect(){
    nodes = [];
    var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
      acceptNode: function(n){
        if(!n.nodeValue || !n.nodeValue.trim()) return NodeFilter.FILTER_REJECT;
        var p = n.parentNode;
        if(!p) return NodeFilter.FILTER_REJECT;
        var tag = p.nodeName.toLowerCase();
        if(tag==='script'||tag==='style'||tag==='noscript') return NodeFilter.FILTER_REJECT;
        if(p.closest && p.closest('.lang-switch')) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var n;
    while(n = walker.nextNode()){
      n.__nl = norm(n.nodeValue);
      n.__raw = n.nodeValue;
      nodes.push(n);
    }
  }
  function apply(lang){
    if (lang !== 'nl' && !TR[lang]) { laadTaal(lang, function(){ apply(lang); }); return; }
    var dict = TR[lang] || null;
    nodes.forEach(function(node){
      if(!node.parentNode){ return; }
      if(lang==='nl' || !dict || dict[node.__nl]==null){
        node.nodeValue = node.__raw;
      } else {
        var raw = node.__raw;
        var lead = raw.match(/^\s*/)[0];
        var trail = raw.match(/\s*$/)[0];
        node.nodeValue = lead + dict[node.__nl] + trail;
      }
    });
    document.documentElement.lang = lang;
    huidig = lang;
    try { localStorage.setItem('helvaro_lang', lang); } catch(e){}
    document.querySelectorAll('.lang-current').forEach(function(c){ c.textContent = LABELS[lang]; });
    document.querySelectorAll('.lang-opt').forEach(function(o){ o.classList.toggle('active', o.getAttribute('data-lang')===lang); });
    applyHero(lang);
    applyTitle(lang);
    applyHtmlBlokken(lang);
    applyPlaceholders(lang, dict);
  }

  /* Placeholders zitten in een attribuut, niet in een tekstknoop, dus die
     ontsnappen aan de TreeWalker. */
  var phNodes = [];
  function collectPlaceholders(root){
    (root || document.body).querySelectorAll('[placeholder]').forEach(function(el){
      if (el.__ph != null) return;
      el.__ph = el.getAttribute('placeholder');
      phNodes.push(el);
    });
  }
  function applyPlaceholders(lang, dict){
    phNodes.forEach(function(el){
      if(!el.isConnected) return;
      var v = (lang==='nl' || !dict) ? null : dict[norm(el.__ph)];
      el.setAttribute('placeholder', v || el.__ph);
    });
  }

  /* Blokken die pas na het laden in de pagina komen, zoals het demo-widget
     dat van app.helvaro.pro wordt gehaald. Nieuwe tekstknopen worden
     opgenomen en meteen in de huidige taal gezet. */
  function collectIn(root){
    var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT, {
      acceptNode: function(n){
        if(!n.nodeValue || !n.nodeValue.trim()) return NodeFilter.FILTER_REJECT;
        var p = n.parentNode;
        if(!p) return NodeFilter.FILTER_REJECT;
        var tag = p.nodeName.toLowerCase();
        if(tag==='script'||tag==='style'||tag==='noscript') return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    var n;
    while(n = walker.nextNode()){
      if(n.__nl != null) continue;
      n.__nl = norm(n.nodeValue);
      n.__raw = n.nodeValue;
      nodes.push(n);
    }
    collectPlaceholders(root);
  }
  /* ----------------------------------------------------------
     Automatische taalkeuze.
     Volgorde: eigen keuze van de bezoeker > ?lang= in de URL >
     browsertaal > tijdzone als landhint > Nederlands.

     Bewust geen IP-geolocatie: dat vereist een externe dienst,
     stuurt het IP van elke bezoeker naar een derde partij (slecht
     te rijmen met onze eigen GDPR-belofte) en vertraagt de pagina.
     Browsertaal en tijdzone komen uit de browser zelf.
     ---------------------------------------------------------- */
  var SUPPORTED = ['nl','fr','en','de','es'];

  /* Tijdzone -> taal. Enkel als de browsertaal niets oplevert. */
  var TZ_LANG = {
    'Europe/Brussels':'nl', 'Europe/Amsterdam':'nl',
    'Europe/Paris':'fr', 'Europe/Monaco':'fr', 'Europe/Luxembourg':'fr',
    'Europe/Madrid':'es', 'Atlantic/Canary':'es', 'Europe/Andorra':'es',
    'Europe/Berlin':'de', 'Europe/Vienna':'de', 'Europe/Zurich':'de'
  };

  function detect(){
    /* 1. ?lang=fr in de URL wint altijd. Een advertentie die naar de Franse
       versie linkt moet dat ook krijgen, ook als de bezoeker eerder wat koos. */
    try {
      var q = (location.search.match(/[?&]lang=([a-zA-Z-]+)/) || [])[1];
      if (q) {
        q = q.slice(0,2).toLowerCase();
        if (SUPPORTED.indexOf(q) >= 0) {
          try { localStorage.setItem('helvaro_lang_set','1'); } catch(err){}
          return q;
        }
      }
    } catch(e){}

    /* 2. Eerdere expliciete keuze van de bezoeker */
    try {
      if (localStorage.getItem('helvaro_lang_set') === '1') {
        var chosen = localStorage.getItem('helvaro_lang');
        if (chosen && SUPPORTED.indexOf(chosen) >= 0) return chosen;
      }
    } catch(e){}

    /* 3. Voorkeurstalen van de browser */
    var langs = navigator.languages && navigator.languages.length
      ? navigator.languages
      : [navigator.language || navigator.userLanguage || ''];
    for (var i = 0; i < langs.length; i++) {
      var code = String(langs[i] || '').slice(0,2).toLowerCase();
      if (SUPPORTED.indexOf(code) >= 0) return code;
    }

    /* 4. Tijdzone als landhint */
    try {
      var tz = Intl.DateTimeFormat().resolvedOptions().timeZone;
      if (TZ_LANG[tz]) return TZ_LANG[tz];
      /* Buiten Europa is Engels de veiligste gok */
      if (tz && tz.indexOf('Europe/') !== 0) return 'en';
    } catch(e){}

    /* 5. Standaard */
    return 'nl';
  }

  function init(){
    heroEl = document.querySelector('.hero-title');
    collect();
    collectPlaceholders();
    apply(detect());

    /* Het demo-widget rendert zichzelf pas na dit punt. Zodra er inhoud
       verschijnt, wordt die alsnog vertaald. */
    var demo = document.getElementById('helvaro-ai-demo');
    if (demo && window.MutationObserver) {
      var wachtend = null;
      new MutationObserver(function(){
        /* Tijdens het typen verandert er van alles in het widget. Even
           wachten scheelt tientallen rondjes over de hele pagina. */
        clearTimeout(wachtend);
        wachtend = setTimeout(function(){
          collectIn(demo);
          apply(huidig);
        }, 120);
      }).observe(demo, { childList: true, subtree: true });
    }
    document.addEventListener('click', function(e){
      var opt = e.target.closest('.lang-opt');
      if(opt){
        /* Vanaf nu telt de keuze van de bezoeker, niet de detectie */
        try { localStorage.setItem('helvaro_lang_set','1'); } catch(err){}
        apply(opt.getAttribute('data-lang'));
        document.querySelectorAll('.lang-switch').forEach(function(s){ s.classList.remove('open'); });
        return;
      }
      var tog = e.target.closest('.lang-toggle');
      if(tog){ var sw = tog.closest('.lang-switch'); var open = sw.classList.toggle('open'); tog.setAttribute('aria-expanded', open?'true':'false'); e.stopPropagation(); return; }
      document.querySelectorAll('.lang-switch.open').forEach(function(s){ s.classList.remove('open'); });
    });
  }
  if(document.readyState==='loading'){ document.addEventListener('DOMContentLoaded', init); } else { init(); }
})();
