# WIP WIP WIP

## Install via shell

```sh
# clone project
git clone https://github.com/ddrscott/mc-uberop.git

# change into directory
cd mc-uberop

# for every save in Minecraft, link the code directory
find ~/Library/Application\ Support/minecraft/saves \
  -maxdepth 2     \
  -type d         \
  -name datapacks \
  -exec ln -s "${PWD}" {}/mc-uberop \;
```
