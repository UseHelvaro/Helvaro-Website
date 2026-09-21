/* ============================================================
   HELVARO — Motion & Signature Animations
   v1 — Leadlijn, per-line reveals, frosted nav, grain overlay
   ============================================================ */

(function() {
  'use strict';

  /* ── Reduced motion check ───────────────────────────────────────────────── */
  var reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  document.addEventListener('DOMContentLoaded', function() {
    initLeadlijn();
    initLineReveal();
    initFrostedNav();
    initPhoneFloat();
    initGrainOverlay();
    initSheenButtons();
  });

  /* ============================================================
     LEADLIJN — the signature sand path between columns
     ============================================================ */
  function initLeadlijn() {
    var diagram = document.querySelector('.stroom-diagram');
    if (!diagram) return;

    // Create SVG overlay
    var svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('class', 'leadlijn-svg');
    svg.setAttribute('aria-hidden', 'true');
    diagram.style.position = 'relative';
    diagram.appendChild(svg);

    // The path and dot elements
    var path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
    path.setAttribute('class', 'leadlijn-path');
    path.setAttribute('fill', 'none');
    path.setAttribute('stroke', 'url(#leadlijn-grad)');
    path.setAttribute('stroke-width', '1.5');

    var dot = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
    dot.setAttribute('class', 'leadlijn-dot');
    dot.setAttribute('r', '6');
    dot.setAttribute('fill', 'var(--accent)');

    // Glow filter and gradient
    var defs = document.createElementNS('http://www.w3.org/2000/svg', 'defs');
    defs.innerHTML =
      '<linearGradient id="leadlijn-grad" x1="0%" y1="0%" x2="100%" y2="0%">' +
        '<stop offset="0%" stop-color="var(--accent-dark)" stop-opacity="0.4"/>' +
        '<stop offset="50%" stop-color="var(--accent)" stop-opacity="0.8"/>' +
        '<stop offset="100%" stop-color="var(--accent-dark)" stop-opacity="0.4"/>' +
      '</linearGradient>' +
      '<filter id="leadlijn-glow" x="-50%" y="-50%" width="200%" height="200%">' +
        '<feGaussianBlur in="SourceGraphic" stdDeviation="4" result="blur"/>' +
        '<feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge>' +
      '</filter>';

    svg.appendChild(defs);
    svg.appendChild(path);
    dot.setAttribute('filter', 'url(#leadlijn-glow)');
    svg.appendChild(dot);

    var steps = diagram.querySelectorAll('.stroom-stappen li');
    var isVisible = false;
    var animFrame = null;

    function updatePath() {
      var rect = diagram.getBoundingClientRect();
      var kolommen = diagram.querySelectorAll('.stroom-kolom');
      if (kolommen.length < 3) return;

      var bron = kolommen[0];
      var kern = kolommen[1];
      var doel = kolommen[2];

      var svgW = rect.width;
      var svgH = rect.height;
      svg.setAttribute('viewBox', '0 0 ' + svgW + ' ' + svgH);
      svg.style.width = svgW + 'px';
      svg.style.height = svgH + 'px';

      // Check if mobile (vertical layout)
      var isMobile = window.innerWidth < 900;

      var bronR = bron.getBoundingClientRect();
      var kernR = kern.getBoundingClientRect();
      var doelR = doel.getBoundingClientRect();

      var x1, y1, x2, y2, x3, y3, d;

      if (isMobile) {
        // Vertical path
        x1 = (bronR.left + bronR.width / 2) - rect.left;
        y1 = bronR.bottom - rect.top;
        x2 = (kernR.left + kernR.width / 2) - rect.left;
        y2 = kernR.top + kernR.height / 2 - rect.top;
        x3 = (doelR.left + doelR.width / 2) - rect.left;
        y3 = doelR.top - rect.top;

        d = 'M' + x1 + ',' + y1 +
            ' C' + x1 + ',' + (y1 + 40) + ' ' + x2 + ',' + (y2 - 40) + ' ' + x2 + ',' + y2 +
            ' C' + x2 + ',' + (y2 + 40) + ' ' + x3 + ',' + (y3 - 40) + ' ' + x3 + ',' + y3;
      } else {
        // Horizontal path
        x1 = bronR.right - rect.left + 8;
        y1 = bronR.top + bronR.height / 2 - rect.top;
        x2 = kernR.left + kernR.width / 2 - rect.left;
        y2 = kernR.top + kernR.height / 2 - rect.top;
        x3 = doelR.left - rect.left - 8;
        y3 = doelR.top + doelR.height / 2 - rect.top;

        var cpX1 = x1 + (x2 - x1) * 0.5;
        var cpX2 = x2 + (x3 - x2) * 0.5;

        d = 'M' + x1 + ',' + y1 +
            ' C' + cpX1 + ',' + y1 + ' ' + cpX1 + ',' + y2 + ' ' + x2 + ',' + y2 +
            ' C' + cpX2 + ',' + y2 + ' ' + cpX2 + ',' + y3 + ' ' + x3 + ',' + y3;
      }

      path.setAttribute('d', d);
      return path.getTotalLength();
    }

    function animateDot() {
      if (!isVisible || reducedMotion) return;

      var length = path.getTotalLength();
      var duration = 8000; // 8 seconds
      var stepDuration = duration / 5;
      var startTime = null;

      steps.forEach(function(s) { s.classList.remove('leadlijn-active'); });

      function frame(time) {
        if (!isVisible) return;
        if (!startTime) startTime = time;

        var elapsed = (time - startTime) % duration;
        var progress = elapsed / duration;

        // Get point on path
        var point = path.getPointAtLength(progress * length);
        dot.setAttribute('cx', point.x);
        dot.setAttribute('cy', point.y);

        // Light up steps based on progress (middle section is 20%-80% of path)
        var stepProgress = Math.max(0, Math.min(1, (progress - 0.2) / 0.6));
        var activeStep = Math.floor(stepProgress * 5);

        steps.forEach(function(s, i) {
          if (i <= activeStep && progress > 0.15) {
            s.classList.add('leadlijn-active');
          } else {
            s.classList.remove('leadlijn-active');
          }
        });

        animFrame = requestAnimationFrame(frame);
      }

      animFrame = requestAnimationFrame(frame);
    }

    // Static state for reduced motion
    function showStatic() {
      updatePath();
      steps.forEach(function(s) { s.classList.add('leadlijn-active'); });
      // Position dot in center
      var length = path.getTotalLength();
      var point = path.getPointAtLength(length * 0.5);
      dot.setAttribute('cx', point.x);
      dot.setAttribute('cy', point.y);
    }

    // Intersection observer
    var observer = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        isVisible = entry.isIntersecting;
        if (isVisible) {
          updatePath();
          if (reducedMotion) {
            showStatic();
          } else {
            animateDot();
          }
        } else {
          if (animFrame) {
            cancelAnimationFrame(animFrame);
            animFrame = null;
          }
        }
      });
    }, { threshold: 0.3 });

    observer.observe(diagram);

    // Update on resize
    var resizeTimeout;
    window.addEventListener('resize', function() {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(function() {
        updatePath();
      }, 100);
    });
  }

  /* ============================================================
     LINE REVEAL — per-line clipped rise reveal for headings
     ============================================================ */
  function initLineReveal() {
    if (reducedMotion) return;

    // Wait for fonts
    document.fonts.ready.then(function() {
      var heroTitle = document.querySelector('.hero-title');
      if (!heroTitle) return;

      // The hero title may have been processed by word-anim already
      // We add a line-reveal class to enable the CSS animation
      heroTitle.classList.add('line-reveal-ready');

      // Find section titles for lighter reveal
      document.querySelectorAll('.section-title').forEach(function(el) {
        el.classList.add('line-reveal-ready');
      });
    });
  }

  /* ============================================================
     FROSTED NAV — glass effect on scroll
     ============================================================ */
  function initFrostedNav() {
    var nav = document.querySelector('.nav');
    if (!nav) return;

    var scrollThreshold = 40;
    var lastScroll = 0;
    var ticking = false;

    function updateNav() {
      var scrollY = window.scrollY || window.pageYOffset;

      if (scrollY > scrollThreshold) {
        nav.classList.add('frosted');
      } else {
        nav.classList.remove('frosted');
      }

      ticking = false;
    }

    window.addEventListener('scroll', function() {
      if (!ticking) {
        requestAnimationFrame(updateNav);
        ticking = true;
      }
    }, { passive: true });

    updateNav();
  }

  /* ============================================================
     PHONE FLOAT — gentle float + cursor tilt
     ============================================================ */
  function initPhoneFloat() {
    var phone = document.querySelector('.phone-wrap');
    if (!phone || reducedMotion) return;

    // Add float animation class
    phone.classList.add('phone-floating');

    // Cursor tilt on desktop
    if (window.matchMedia('(hover: hover)').matches) {
      var hero = document.querySelector('.hero');
      if (!hero) return;

      hero.addEventListener('mousemove', function(e) {
        var rect = hero.getBoundingClientRect();
        var centerX = rect.left + rect.width / 2;
        var centerY = rect.top + rect.height / 2;

        var deltaX = (e.clientX - centerX) / rect.width;
        var deltaY = (e.clientY - centerY) / rect.height;

        var rotateY = deltaX * 2; // max 2 degrees
        var rotateX = -deltaY * 1.5; // max 1.5 degrees

        phone.style.transform = 'rotateX(' + rotateX + 'deg) rotateY(' + rotateY + 'deg)';
      });

      hero.addEventListener('mouseleave', function() {
        phone.style.transform = '';
      });
    }
  }

  /* ============================================================
     GRAIN OVERLAY — subtle noise texture
     ============================================================ */
  function initGrainOverlay() {
    // Create grain SVG filter
    var grainSvg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    grainSvg.setAttribute('class', 'grain-svg');
    grainSvg.setAttribute('aria-hidden', 'true');
    grainSvg.innerHTML =
      '<defs>' +
        '<filter id="grain-filter" x="0%" y="0%" width="100%" height="100%">' +
          '<feTurbulence type="fractalNoise" baseFrequency="0.7" numOctaves="3" stitchTiles="stitch" result="noise"/>' +
          '<feColorMatrix type="saturate" values="0" in="noise" result="mono"/>' +
          '<feBlend in="SourceGraphic" in2="mono" mode="multiply"/>' +
        '</filter>' +
      '</defs>';
    document.body.appendChild(grainSvg);

    // Create grain overlay div
    var grainDiv = document.createElement('div');
    grainDiv.className = 'grain-overlay';
    grainDiv.setAttribute('aria-hidden', 'true');
    document.body.appendChild(grainDiv);
  }

  /* ============================================================
     SHEEN BUTTONS — sand sheen sweep on hover
     ============================================================ */
  function initSheenButtons() {
    if (reducedMotion) return;

    document.querySelectorAll('.btn:not(.btn-ghost)').forEach(function(btn) {
      // Create sheen element
      var sheen = document.createElement('span');
      sheen.className = 'btn-sheen';
      btn.appendChild(sheen);

      btn.addEventListener('mouseenter', function() {
        sheen.classList.add('active');
      });

      btn.addEventListener('mouseleave', function() {
        sheen.classList.remove('active');
      });
    });
  }

})();
