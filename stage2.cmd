@echo off

powershell -c "Invoke-WebRequest -Uri 'ipv4.download.thinkbroadband.com/50MB.zip' -Outfile 'poc.zip'"