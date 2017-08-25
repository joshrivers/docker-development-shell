source <(npm completion)
complete -C '/usr/local/bin/aws_completer' aws
if [ -x /root/.bashrc-local ]; then
  source /root/.bashrc-local
fi