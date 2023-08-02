def main [command: string] {
  if ($command == "rebuild") {
    rebuild
  }
}

export def monitor [] {
  let path = ([$env.HOME "system"] | path join)
  cd $path
  watchexec --exts=nix nu main.nu rebuild
}

export def rebuild [] {
  let path = ([$env.HOME "system"] | path join)
  cd $path
  git add .
  sudo nixos-rebuild switch --impure --flake $"($path)#host-default" --show-trace
}

export def syntaxes [] {
  let path = ([$env.HOME ".config" "tree-sitter" "syntaxes"] | path join)
  mkdir $path
  open meta.yml | get syntaxes | par-each {|url|
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

export def contribution [org = "cognitive-singularity", path = "contribution"] {
  let meta_path = ([$env.HOME "system" "meta.yml"] | path join)
  let dist_path = ([$env.HOME $path] | path join)
  mkdir $dist_path
  cd $dist_path
  gh repo list $org -L 2 --json owner,name,parent
  | from json
  | par-each {|data|
    let entry = {
      origin_owner: ()
      origin_name: ()
      parent_owner: ()
      parent_name: ()
    }

    # git clone $url ($url | url parse | get path | str downcase | split column "/" | get column3)
  }
}

export def generate [] {

}

export def generate [] {
  cd $env.HOME
  alias td = terminusdb
}
  
export def upload [message: string] {
  let path = ([$env.HOME "system"] | path join)
  cd $path
  git add .
  git commit --message $message
  git push
}

export def review [path: string, type = all] {
  cd $path
  rg --files --sort path --type $type --hidden | lines | hx $in
}

export def unpack [] {
  let path = ([$env.HOME "Downloads"] | path join)
  cd $path
  ["zip" "rar" "gz" "7z"]
  | each {|extension|
    glob --no-dir $"**/*.($extension)"
    | each {|file|
      run-external "7z" "x" "-y" $file $"-o($file | str replace $extension '')"
      rm --force $file
    }
  }
}

export def archive [] {
  let source_directory = ([$env.HOME "Downloads"] | path join)
  let target_directory = ([$env.HOME "archive"] | path join)
  mkdir $target_directory
 ["fb2" "epub" "mobi" "pdf" "djv" "djvu" "doc" "docx" "xls" "xlsx" "ppt" "pptx" "rtf" "json" "csv" "yaml" "yml" "adoc" "txt" "png" "jpg" "jpeg" "mp3" "mp4" "m4a" "html" "htm" "htz" "chm" "xml" "png" "mp4" "arf" "svg" "webp" "webm"]
  | each {|extension|
    glob --no-dir $"**/*.($extension)"
    | each {|source_file|
      let distination_directory = ([$target_directory $extension] | path join)
      mkdir $distination_directory
      let hash = (cat $source_file | hash sha256)
      let target_file = ({
        parent: $distination_directory
        stem: $hash
        extension: $extension
      } | path join)
      mv --force $source_file $target_file
      let origin_file = ($source_file | str replace $"($source_directory)/" "")
      let target_file = ({
        stem: $hash
        extension: $extension
      } | path join)
      let entry = {
        origin: $origin_file
        target: $target_file
      }
      let index = ([$target_directory "index.yml"] | path join)
      if (not ($index | path exists)) { touch $index }
      open $index | append $entry | to yaml | save --force $index
    }
  }
  cd $target_directory
  ls | where type == dir | get name | each {|dir|
    let file = ({stem: $dir, extension: "tar.gz"} | path join)
    tar czf $file $dir
  }
}
