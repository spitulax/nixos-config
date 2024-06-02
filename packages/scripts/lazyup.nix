{ writeShellScriptBin }:
writeShellScriptBin "lazyup" ''

LAZYLOCK_PATH=$HOME/.config/nvim/lazy-lock.json
[[ ! -r $LAZYLOCK_PATH ]] && echo "$LAZYLOCK_PATH does not exist" && exit 1

cd $FLAKE
unlink $LAZYLOCK_PATH
nvim . # run lazy.nvim commands
cp $LAZYLOCK_PATH modules/home/bintang/nvim/lazy-lock.json
rm $LAZYLOCK_PATH
echo "You can build your system now to place the lock file back."

''
