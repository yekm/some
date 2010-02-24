#!/bin/sh

convmv -f cp1252 -t cp850 --notest -r ./
convmv -f cp866 -t utf8 --notest -r --nosmart --nfc ./

