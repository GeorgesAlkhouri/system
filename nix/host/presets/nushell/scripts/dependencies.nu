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

  $list | each {|item|
    let origin_url = ($item | get origin)
    let parent_url = ($item | get parent)

    let name = ($origin_url | split column "/" | get column2 | to text | path parse | get stem | str downcase)

    let dist = ([$dist $name] | path join)

    if ($dist | path exists) {
      cd $dist

      git pull origin main
      git fetch upstream
      git switch upstream-sync
      git merge (["upstream" (get_head $parent_url)] | path join)
      git switch main
      git merge upstream-sync
      git push origin main
    } else {
      git clone $origin_url $dist

      cd $dist

      git remote add upstream $parent_url
      git fetch upstream
      git switch -c upstream-sync
      git merge (["upstream" (get_head $parent_url)] | path join)
      git switch -c main
      git merge upstream-sync
      git push origin main
      git branch -m master main
      git push -u origin main
      git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
      git push origin --delete master
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
