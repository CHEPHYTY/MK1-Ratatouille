# MK1-Ratatouille

# Project : RAT

> **Red CHEPHYTY** | 15/5/24

### Overview :

We developing a remote access tool [RAT].We can use this to command and control [C2] target computers .

### Resource :

- [DucKey Logger] \_(.)

```
# show file
attrib -h -s -r FILE


# hide file
attrib +h +s +r FILE

```

### Components :

- keylogger
  - backspace detection
- screen shots
- webcam
- exfiltration
  - capturing documents
- remote access
- credential
  - web
  - computer
  - application
  - wi-fi
- advanced reconnaissance
  - Contact Info
- privesc
- worm
- upload, download and add process on demand

### Roadmap :
- add exception to temp folder
- finish advanced staging for remote connection
    - persistant ssh
    - admin account and registry
    - reconnaissance scan 
      - ip addr for ssh
      - smtp results
    -vm detection [wait]

- establish attacker console
  - python
  - send commands back and forth [ssh]
  - modular interface
  - target pc to host socket
- redevelop keylogger
- screenshots
- webcam
- obtaining credential
- obfuscation
  - av, vm detection
  - disabling firewall, av

## Stages :

1. initial payload creates files in start up directory
   - cmd to run administrative commands
     - set exec bypass
   - vbs file to hold `alt` + `y` for UAC bypass
   - self delete
2. new malware initialize remote connection

   - any additional tools can be installed remotely
   - keeps a low profile on the payload

3. modularity
   - having a directory to store resource for the RAT

### Extraneous :

- bsod
- web history
- user activity

Titls

- Packman
- Mach 1
- Komputer Access
- MK
- Ratatouille
- Turnover

#Projects #Malware
