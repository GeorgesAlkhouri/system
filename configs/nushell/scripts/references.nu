export def multigrep [type: string, ...queries] {
  let path = ([$env.HOME "references"] | path join)

  cd $path

  mut out = { }

  let rp = (fd --hidden ".git$" | lines | path parse | get parent)
  $out = ($out | insert rp $rp)

  let q1 = ($queries | get --ignore-errors 0)
  let q2 = ($queries | get --ignore-errors 1)
  let q3 = ($queries | get --ignore-errors 2)

  if (not ($q1 | is-empty)) {
    let s = (rg --type nix $q1 --files-with-matches | lines | path parse | get parent | uniq)
    $out = ($out | insert s1 $s)
  }
  if (not ($q2 | is-empty)) {
    let s = (rg --type nix $q2 --files-with-matches | lines | path parse | get parent | uniq)
    $out = ($out | insert s2 $s)
  }
  if (not ($q3 | is-empty)) {
    let s = (rg --type nix $q3 --files-with-matches | lines | path parse | get parent | uniq)
    $out = ($out | insert s3 $s)
  }
  
  # $out | get rp | each {|i|

  #   $i
  # }
  $out | to yaml | save -f a.yml
  
}
