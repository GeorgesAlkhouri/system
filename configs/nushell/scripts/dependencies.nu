alias c = contribute
alias d = discovery
alias m = multigrep
alias r = review
alias t = traverse

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

      let branch_parent = (get_head $parent_url)
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

def get_head [parent: string] {
  git remote show $parent
  | find 'HEAD branch'
  | ansi strip
  | split column ':'
  | get column2
  | to text
  | str trim
}

export def discovery [] {
  http get "https://api.ossinsight.io/public"
}

def reg [type: string, query: string] {
  rg --type $type $query --files-with-matches
  | lines
  | path parse
  | get parent
  | uniq
  | split column "/"
  | get column1
  | uniq    
}

export def multigrep [type: string, query1 = "", query2 = "", query3 = ""] {
  cd ([$env.HOME "references"] | path join)

  let repos = (fd --hidden ".git$" | lines | path parse | get parent | split column "/" | get column1)

  let found = [(reg $type $query1) (reg $type $query2) (reg $type $query3)]

  let list = ($repos | each {|i| $found | all {|e| (not ($e | find $i | is-empty)) } | if ($in == true) { $i }})

  $list | sort | uniq
}

export def-env traverse [dir = "contribute"] {
  cd ([$env.HOME $dir] | path join)

  if ($env | get COUNTER | is-empty) {
    $env.COUNTER = 0
  }

  if (ls | get ($env.COUNTER | into int) | is-empty) {
      $env.COUNTER = ""
      traverse
  }

  ls | get ($env.COUNTER | into int) | get name | review $in

  $env.COUNTER  = (($env.COUNTER | into int)  + 1)
}

export def review [path: string, type = all] {
  cd $path
  rg --files --sort path --type $type --hidden | lines | where {|i| $i !~ ".git/"} | hx $in
}

export def syntaxes [] {
  let list = $in
  let path = ([$env.HOME ".config" "tree-sitter" "syntaxes"] | path join)

  mkdir $path

  $list | par-each {|url|
    let name = ($url | url parse | get path | split column "/" | get column3 | to text)
    let dist = ([$path $name] | path join | str downcase)

    if ($dist | path exists) {
      cd $dist
      git pull
    } else {
      git clone $url $dist
    }
  }
}

export def models [] {
  let list = $in
  let path = ([$env.HOME "models"] | path join)

  mkdir $path

  $list | par-each {|item|
    let name = ($item | path parse | [($in | get stem) ($in | get extension)] | str join ".")
    let dist = ([$path $name] | path join | str downcase)
    if (not ($dist | path exists)) {
      http get $item | save $dist
    }
  }
}
