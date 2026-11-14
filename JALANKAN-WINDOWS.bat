@echo off
cd /d "%~dp0site"
start "" http://localhost:5173/en/
py -3 -m http.server 5173 || python -m http.server 5173
pause
