export def models [] {
  let meta = ([$env.HOME "system" "meta.yml"] | path join)
  let path = ([$env.HOME "models"] | path join)
  let list = (open $meta | get models)
  cd $path
  $list | par-each {|item|
    let dist = ($item | path parse | [($in | get stem) ($in | get extension)] | str downcase | str join ".")
    if (not ($dist | path exists)) {
      http get $item | save $dist
    }
  }
}

export def syntaxes [] {
  let meta = ([$env.HOME "system" "meta.yml"] | path join)
  let path = ([$env.HOME ".config" "tree-sitter" "syntaxes"] | path join)
  mkdir $path
  open $meta | get syntaxes | par-each {|url|
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
