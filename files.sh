mkdir -p index
for x in nix toml md rs sh mzn py ts js css scss exe bat hs txt org git submodules gitignore 
do echo $x
   grep "\.${x}" file.txt > index/file_${x}.txt
done
