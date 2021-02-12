from mcrcon import MCRcon
import os

with MCRcon('localhost', os.getenv('RCON_PASSWORD')) as mcr:
    resp = mcr.command("reload")
    print(resp)
    # print(mcr.command("execute positioned 100 40 0 rotated 0 0 run function uberop:make/stadium-24"))
    # print(mcr.command("execute positioned -13 110 24 rotated 0 0 run function uberop:canons/standard"))
