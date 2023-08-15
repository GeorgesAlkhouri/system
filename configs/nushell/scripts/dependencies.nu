export def contribute [org = "cognitive-singularity", path = "contribute"] {
  let meta = ([$env.HOME $path "meta.yml"] | path join)
  let dist = ([$env.HOME $path] | path join)

  let git_pref = "git@github.com:"
  let git_post = ".git"
  let git_url = { scheme: "https" host: "github.com" }

  mkdir $dist

  let collection_name = "collection"

  {$collection_name: []} | to yaml | save --force $meta

  gh repo list $org --limit 1000 --fork --json owner,name,parent | from json | each {|item|
    let origin_owner = ($item | get owner.login)
    let origin_name = ($item | get name)
    let parent_owner = ($item | get parent.owner.login)
    let parent_name = ($item | get parent.name)

    let origin_full_path = ([$origin_owner $origin_name] | path join)
    let parent_full_path = ([$parent_owner $parent_name] | path join)

    let entry = {
      origin: ([$git_pref $origin_full_path $git_post] | str join)
      parent: ($git_url | merge {path: ([$parent_owner $parent_name] | path join)} | url join)
    }

    let collection = (open $meta | get $collection_name | append $entry)

    open $meta | update $collection_name $collection | to yaml | save --force $meta
  }

  let list = (open $meta | get $collection_name)

  $list | par-each {|item|
    let origin_url = ($item | get origin)
    let parent_url = ($item | get parent)
    let name = ($origin_url | split column "/" | get column2 | to text | path parse | get stem | str downcase)
    let dist = ([$dist $name] | path join)

    if (not ($dist | path exists)) {
      git clone $origin_url $dist
      cd $dist
      git remote add upstream $parent_url
    }
  }

  $list | each {|item|
    let origin_url = ($item | get origin)
    let parent_url = ($item | get parent)
    let name = ($origin_url | split column "/" | get column2 | to text | path parse | get stem | str downcase)
    let dist = ([$dist $name] | path join)

    if ($dist | path exists) {
      cd $dist

      let branch_parent = (get-head $parent_url)
      let branch_upstream = "upstream-sync"
      let branch_target = "cognitive-singularity"

      git fetch origin
      git fetch upstream


      git switch $branch_parent
      git merge (["upstream" $branch_parent] | path join)

      try { git switch $branch_upstream } catch { git switch --create $branch_upstream }

      git merge (["upstream" $branch_parent] | path join)

      try { git switch $branch_target } catch { git switch --create $branch_target }

      git push origin --all
      git push origin --tags
    }
  }
}

def get-head [parent: string] {
  git remote show $parent
  | find 'HEAD branch'
  | ansi strip
  | split column ':'
  | get column2
  | to text
  | str trim
}

export def multigrep [type: string, query1 = "", query2 = "", query3 = ""] {
  let dir = pwd
  cd $dir
  let repos = (glob */.git | lines | path parse | get parent | path parse | get stem)
  let found = [(find-match $type $query1) (find-match $type $query2) (find-match $type $query3)]
  let filtered = ($found | where {|i| (not ($i | is-empty))})
  let list = ($repos | each {|i| $filtered | all {|e| (not ($e | find $i | is-empty)) } | if ($in == true) { [$dir $i] | path join }})

  $list | sort | uniq
}

def find-match [type: string, query: string] {
  if ($query | is-empty) {
    []    
  } else {
    rg --type $type $query --files-with-matches
    | lines
    | path parse
    | get parent
    | uniq
    | split column "/"
    | get column1
    | uniq    
  }
}

export def review [arg = all] {
  cd $in
  mut list = []
  if (rg --type-list | lines | split column ":" | get column1 | find $arg | is-empty) { 
    $list = (rg --files --sort path --glob $arg --hidden | lines)
  } else {
    $list = (rg --files --sort path --type $arg --hidden | lines)
  }
  if (not ($list | is-empty)) { $list | hx $in }
}

export def-env next [arg: string] {
  let arg = ([$env.HOME ($arg | str replace "~/" "")] | path join)
  try {$env.COUNTER} catch { $env.COUNTER = 0 }
  let counter = ($env.COUNTER | into int)
  let list = (if (($arg | path type) == "file") {let a = (open $arg | lines); $a} else {(ls $arg | get name)})
  let dist = ($list | get $counter)
  $env.COUNTER = ($counter + 1)
  if ($dist | path exists) { cd $dist }
  clear
  show-all
}

export def-env counter-reset [] {
  $env.COUNTER = 0
}

export def show-all [] {
  ls --all **/*
  | where name !~ ".direnv/"
  | where name !~ ".git/"
  | where name !~ "node_modules"  
}
