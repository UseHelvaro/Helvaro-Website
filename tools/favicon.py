#!/usr/bin/env python3
"""
Maakt de favicons met een doorzichtige achtergrond.

    python3 tools/favicon.py

Sinds 24 sep 2026 is de bron het zandkleurige embleem (logo-sand@2x.png),
hetzelfde zand als het woordmerk in de balk. Dat bestand is al doorzichtig,
dus er valt niets los te snijden: alleen strak bijsnijden zodat het embleem
het hele tabblad vult. De oude weg (gouden embleem van icon-512 halen)
staat hieronder nog voor de apple-touch-icon-uitleg.

De bron is assets/icon-512.png: het embleem op een bijna zwarte plaat.
Die plaat heeft overal helderheid 18, het embleem 110 en hoger, dus de
twee zijn schoon te scheiden op helderheid. De zachte rand van het
embleem blijft daarbij bewaard.

icon-512.png en apple-touch-icon.png blijven wel hun plaat houden.
De eerste is de afbeelding die meekomt bij het delen van een link, en
daar staat een doorzichtige achtergrond lelijk. iOS vult doorzichtigheid
in een app-icoon gewoon op met zwart, dus daar wint de plaat ook.
"""
from PIL import Image

BRON = "assets/icon-512.png"
ONDER, BOVEN = 24, 62      # helderheid waartussen de rand overloopt


def doorzichtig():
    im = Image.open(BRON).convert("RGBA")
    grijs = im.convert("L")
    oud = im.getchannel("A")

    def ramp(p):
        if p <= ONDER:
            return 0
        if p >= BOVEN:
            return 255
        return int(255 * (p - ONDER) / (BOVEN - ONDER))

    nieuw = grijs.point(ramp)
    # de ronde hoeken van de plaat blijven doorzichtig
    nieuw = Image.composite(nieuw, Image.new("L", im.size, 0), oud.point(lambda p: 255 if p > 8 else 0))
    im.putalpha(nieuw)
    return im


def bijsnijden(im, marge=0.08):
    """Het embleem vult maar 41% van de plaat. Zonder plaat is die lucht
    zonde: op zestien pixels blijft er dan een vlekje over. Dus snijden we
    strak om het embleem heen, met een klein beetje marge."""
    a = im.getchannel("A")
    l, bo, r, on = a.point(lambda p: 255 if p > 25 else 0).getbbox()
    mx, my = (l + r) / 2.0, (bo + on) / 2.0
    half = max(r - l, on - bo) / 2.0 * (1 + marge)
    vak = (int(mx - half), int(my - half), int(mx + half), int(my + half))
    print("embleem bijgesneden naar", vak)
    return im.crop(vak)


ZAND = "assets/logo-sand@2x.png"
PLAAT = (18, 18, 18, 255)   # #121212, de achtergrond en theme-color van de site


def main():
    groot = bijsnijden(Image.open(ZAND).convert("RGBA"), marge=0.02)
    for maat, naam in ((32, "assets/favicon-32.png"), (16, "assets/favicon-16.png")):
        groot.resize((maat, maat), Image.LANCZOS).save(naam)
        print(naam, "geschreven")
    groot.resize((48, 48), Image.LANCZOS).save(
        "assets/favicon.ico", sizes=[(16, 16), (32, 32), (48, 48)])
    print("assets/favicon.ico geschreven")

    # Google zet het icoon in de zoekresultaten in een CIRKEL en pakt het
    # grootste icoon dat hij vindt (minstens 48px). Met alleen 16 en 32 nam
    # hij de oude apple-touch-icon: een plaat met een klein embleem, dat
    # werd een zwart rondje met een stipje. Deze twee zijn dus ondoorzichtig
    # (iOS vult doorzichtig toch met zwart) op de achtergrond van de site,
    # met het embleem op 64% zodat het ook in de cirkel helemaal binnen valt.
    for maat, naam in ((192, "assets/favicon-192.png"), (180, "assets/apple-touch-icon.png")):
        plaat = Image.new("RGBA", (maat, maat), PLAAT)
        e = int(round(maat * 0.64))
        embleem = groot.resize((e, e), Image.LANCZOS)
        plaat.alpha_composite(embleem, ((maat - e) // 2, (maat - e) // 2))
        plaat.convert("RGB").save(naam, optimize=True)
        print(naam, "geschreven")


if __name__ == "__main__":
    main()
