#!/bin/bash

cd /home/terraria/tshock
mono --server --gc=sgen -O=all TerrariaServer.exe -configpath /terraria/config -worldpath /terraria/world -logpath /terraria/log