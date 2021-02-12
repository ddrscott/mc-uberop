#!/usr/bin/env python

from mcrcon import MCRcon
import os
import sys

with MCRcon('localhost', os.getenv('RCON_PASSWORD')) as mcr:
    for a in ' '.join(sys.argv[1:]).split(";"):
        cmd = a.strip()
        print('/' + cmd)
        mcr.command(cmd)
