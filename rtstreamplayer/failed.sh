#! /bin/sh -eux

daemon -r -n backupplayer -- mpg123 --shuffle -- ~/mp3/*

