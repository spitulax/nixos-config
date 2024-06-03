{ writeShellScriptBin }:
writeShellScriptBin "lazyup" ''

LAZYLOCK_PATH=$HOME/.config/nvim/lazy-lock.json
cd $FLAKE
[[ -r $LAZYLOCK_PATH ]] && unlink $LAZYLOCK_PATH

nvim . # run lazy.nvim commands
cp $LAZYLOCK_PATH modules/home/bintang/nvim/lazy-lock.json
rm $LAZYLOCK_PATH
echo "You can build your system now to place the lock file back."

''
