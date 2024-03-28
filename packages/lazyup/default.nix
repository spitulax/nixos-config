{ writeShellScriptBin }:
writeShellScriptBin "lazyup" ''

LAZYLOCK_PATH=$HOME/.config/nvim/lazy-lock.json

cd $FLAKE
unlink $LAZYLOCK_PATH
nvim --headless "+Lazy! update" "+qa"
cp $LAZYLOCK_PATH users/bintang/nvim/lazy-lock.json
rm $LAZYLOCK_PATH
make home

''
