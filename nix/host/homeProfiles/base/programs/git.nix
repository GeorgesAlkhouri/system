{
  enable = true;
  lfs = { enable = true; };
  extraConfig = {
    push = { autoSetupRemote = true; };
    commit = { verbose = true; };
    fetch = { prune = true; };
    http = { sslVerify = true; };
    init = { defaultBranch = "main"; };
    pull = { rebase = true; };
    push = { followTags = true; };
  };
  aliases = {
    fix = "commit --amend --no-edit";
    res = "reset HEAD~1";
    sub = "submodule update --init --recursive";
  };
  delta = {
    enable = false;
    options = {
      side-by-side = true;
      line-numbers = true;
    };
  };
  difftastic = { enable = true; };
  includes = [{ path = "~/.gitconfig"; }];
}
