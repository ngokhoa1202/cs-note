#ubuntu #os #java #python #fedora  

- The example is the same as configuration for Java alternatives.
# List alternatives
```bash title='List alternatives command'
sudo update-alternatives --list python
```

# Install alternatives
- Alternatives are locally chosen to be installed for alternative configuration options.
```bash title='Locally install alternatives'
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.4 2
```

# Select alternatives
- Alternatives are selected based on priority
```bash title='Update alternatives for language version'
sudo update-alternatives --config python
```

---
# References
1. https://superuser.com/questions/1763779/how-to-configure-alternatives-for-python
2. https://linuxconfig.org/how-to-change-from-default-to-alternative-python-version-on-debian-linux