def create_left_prompt [] {
    mut home = $env.HOME

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace --string $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)"

    $path_segment | str replace --all --string (char path_sep) $"($separator_color)/($path_color)"
}

def create_right_prompt [] {
    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    $last_exit_code
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

$env.PROMPT_INDICATOR = {|| " > " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| " : " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| " > " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
    ($env.HOME | path join 'system/configs/nushell/scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
    ($env.HOME | path join 'system/configs/nushell/plugins')
]

# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.TERMINUSDB_ACCESS_TOKEN = (open /home/nixos/.config/terminusdb/terminusdb_access_token)

$env.GH_TOKEN = (open /home/nixos/.config/gh/gh_token)
$env.GH_TOKEN_PERSONAL = (open /home/nixos/.config/gh/gh_token_personal)

$env.GITHUB_TOKEN = (open /home/nixos/.config/gh/gh_token)
$env.GITHUB_USER = "cognitive-singularity"
$env.GITHUB_REPO = "cluster"

$env.EDITOR = hx
