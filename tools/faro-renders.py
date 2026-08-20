#!/usr/bin/env python3
"""
Maakt van de twee Faro-renders de bestanden die de site gebruikt.

    python3 tools/faro-renders.py <zwarte-render.png> <witte-render.png>

De zwarte render laat zich niet los knippen van zijn achtergrond: zijn
veren zijn even donker als het zwart waarop hij staat, dus elke uitsnede
op helderheid eet gaten in zijn lijf.

De truc is dat het dezelfde figuur is in dezelfde pose en hetzelfde kader.
We halen het silhouet dus uit de witte render, waar wit op zwart genoeg
contrast geeft, en leggen datzelfde silhouet over de zwarte. Gecontroleerd:
minder dan een promille van de zwarte render valt erbuiten, en dat is
alleen de zachte rand.

Beide krijgen daarna hetzelfde kader, zodat er niets verspringt wanneer
een bezoeker van thema wisselt.
"""
import sys
from PIL import Image, ImageDraw, ImageFilter

DOEL = 840        # afmeting van het eindbestand
LUCHT = 1.12      # marge rond Faro
TOLERANTIE = 40   # hoe ver de vulling vanaf de hoeken mag doorlopen
VLOER = 0.893     # alles daaronder is de weerspiegeling op de vloer


def silhouet(wit):
    """Het silhouet van Faro, gehaald uit de witte render."""
    vlak = wit.convert("L")
    for hoek in ((0, 0), (wit.width - 1, 0), (0, wit.height - 1), (wit.width - 1, wit.height - 1)):
        ImageDraw.floodfill(vlak, hoek, 255, thresh=TOLERANTIE)
    masker = vlak.point(lambda p: 0 if p == 255 else 255)

    # De weerspiegeling op de vloer hoort er niet bij.
    ImageDraw.Draw(masker).rectangle(
        (0, int(wit.height * VLOER), wit.width, wit.height), fill=0)

    # Twee versies. De zwarte render heeft een paar pixels extra nodig om
    # zijn zachte rand mee te nemen. Bij de witte zou diezelfde verruiming
    # een grijs randje meepakken van de zwarte achtergrond, dus die krijgt
    # het silhouet strak op maat.
    strak = masker.filter(ImageFilter.GaussianBlur(1.2))
    ruim = masker.filter(ImageFilter.MaxFilter(5)).filter(ImageFilter.GaussianBlur(1.4))
    return strak, ruim


def bouw(zwart_pad, wit_pad):
    zwart = Image.open(zwart_pad).convert("RGB")
    wit = Image.open(wit_pad).convert("RGB")
    if zwart.size != wit.size:
        sys.exit("De twee renders moeten even groot zijn: %s tegen %s" % (zwart.size, wit.size))

    strak, ruim = silhouet(wit)
    kader = strak.point(lambda p: 255 if p > 40 else 0).getbbox()
    l, bo, r, on = kader
    print("Faro staat op", kader, "en is %d bij %d" % (r - l, on - bo))

    # Vierkant kader met wat lucht, voor beide renders hetzelfde.
    mx, my = (l + r) / 2.0, (bo + on) / 2.0
    half = max(r - l, on - bo) / 2.0 * LUCHT
    vak = (int(mx - half), int(my - half), int(mx + half), int(my + half))
    print("kader:", vak)

    for naam, bron, masker in (("faro-donker", zwart, ruim), ("faro-wit", wit, strak)):
        vel = bron.convert("RGBA")
        vel.putalpha(masker)
        # Buiten het oorspronkelijke beeld valt niets, dus eerst op een
        # doorzichtig doek plakken en dan pas uitsnijden.
        doek = Image.new("RGBA", bron.size, (0, 0, 0, 0))
        doek.alpha_composite(vel)
        uit = doek.crop(vak).resize((DOEL, DOEL), Image.LANCZOS)
        uit.save("assets/%s.png" % naam, "PNG", optimize=True)
        uit.save("assets/%s.webp" % naam, "WEBP", quality=90, method=6, exact=True)
        print("assets/%s.png en .webp geschreven" % naam)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    bouw(sys.argv[1], sys.argv[2])
