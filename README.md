# WIP WIP WIP

## Install via shell

```sh
# clone project
git clone https://github.com/ddrscott/mc-uberop.git

# change into directory
cd mc-uberop

# for every save in Minecraft, link the code directory
find "${HOME}/Library/Application Support/minecraft/saves" \
   -name datapacks \
   -type d         \
   -maxdepth 2     \
   -exec ln -vs ~/code/mc-uberop '{}' \;
```
