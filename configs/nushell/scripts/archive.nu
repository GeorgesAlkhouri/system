export def unpack [] {
  let path = ([$env.HOME "Downloads"] | path join)
  cd $path

  ["zip" "rar" "7z"]
  | each {|extension|
    glob --no-dir $"**/*.($extension)"
    | each {|file|
      run-external "7z" "x" "-y" $file $"-o($file | str replace $extension '')"
      rm --force $file
    }
  }
  glob --no-dir **/*.tar.gz
  | each {|file|
    run-external "tar" "xzf" $file
    rm --force $file
  }
}

export def extract [] {
  let source_directory = ([$env.HOME "Downloads"] | path join)
  let target_directory = ([$env.HOME "archive"] | path join)
  let extensions = [
    "adoc"
    "arf"
    "chm"
    "csv"
    "djv"
    "djvu"
    "doc"
    "docx"
    "epub"
    "fb2"
    "htm"
    "html"
    "htz"
    "jpeg"
    "jpg"
    "json"
    "m4a"
    "mobi"
    "mp3"
    "mp4"
    "mp4"
    "pdf"
    "png"
    "png"
    "ppt"
    "pptx"
    "rtf"
    "svg"
    "txt"
    "webm"  
    "webp"
    "xls"
    "xlsx"
    "xml"
    "yaml"
    "yml"
  ]

  mkdir $target_directory
  cd $source_directory

  $extensions | each {|extension|
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
}

export def compress [] {
  let source_directory = ([$env.HOME "archive"] | path join)
  let target_directory = ([$env.HOME "compressed"] | path join)
  
  mkdir $target_directory

  ls $source_directory | where type == dir | get name | each {|dir|
    let file = ({parent: $target_directory, stem: ($dir | path parse | get stem), extension: "tar.gz"} | path join)
    $dir
    tar czf $file --absolute-names $dir
  }
}
