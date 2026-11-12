@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Diff-VTuberv2
node "%~dp0bin\diff-vtuberv2.mjs" %*
pause
