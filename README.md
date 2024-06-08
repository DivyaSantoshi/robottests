This project uses Robot Framework and selenium to run browser specific operations.

# Setup

Make sure python version 3.10 or 3.11 is installed.
```
git clone git@github.com:Anitakreddy/robottests.git
cd robottests
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

# Run the tests


`robot scenarios.robot`

By default the browser runs in normal mode. 
To run in headless mode, change the "Browser" variable to "headlesschrome" in 
variables.resource file.
