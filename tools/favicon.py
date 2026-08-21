#!/usr/bin/env python3
"""
Maakt de favicons met een doorzichtige achtergrond.

    python3 tools/favicon.py

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


def main():
    groot = bijsnijden(doorzichtig())
    for maat, naam in ((32, "assets/favicon-32.png"), (16, "assets/favicon-16.png")):
        groot.resize((maat, maat), Image.LANCZOS).save(naam)
        print(naam, "geschreven")
    groot.resize((64, 64), Image.LANCZOS).save(
        "assets/favicon.ico", sizes=[(16, 16), (32, 32), (48, 48)])
    print("assets/favicon.ico geschreven")
    groot.resize((512, 512), Image.LANCZOS).save("assets/logo-mark.png")
    print("assets/logo-mark.png geschreven (embleem zonder plaat)")


if __name__ == "__main__":
    main()
