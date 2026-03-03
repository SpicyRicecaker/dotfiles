enum MoveRes {
    Ok,
    Conflict(String),
    Other(String)
}

fn is_rel(PathBuf p) -> bool {
    p.is_absolute()
}

fn get_absolute(PathBuf r, PathBuf c) {
    if r.is_absolute {
        a
    } else {
        let mut t = c.clone();
        t.push(r);
        t
    }
}

#[test]
fn test_get_absolute() {
    assert_eq!(get_absolute("./ab", "~/lol"), "~/lol/ab");
    assert_eq!(get_absolute("/one", "~/lol"), "/one/f");
}

// fn get_target_dir_from_arg(

fn main () {
    let p = get_absolute(get_path_from_arg(), get_current_dir());
    let t = get_target_dir_from_arg();
    let s = get_stow_dir_from_arg();
    let r = get_path_p_rel_t(p, t);
    match move_source_to_target_rel(p, t, r) {
        Ok => println!("success"),
        Conflict(s) | Other(s) => println!("{s}")
    };

    // main
    // 1. run get_absolute(get_path_from_arg, get_current_dir) -> p
    // 2. run get_target_dir_from_arg -> t
    // 3. run get_stow_dir_from_arg -> s
    // 4. run get_path_p_rel_t(p, t) -> r
    // 5. run move_source_to_target_rel(p, t, r)

    // get_target_dir_from_arg
    // output:
    //   - string, representing the directory we wish to get target from

    // get_stow_dir_from_arg
    // output:
    //   - string, representing the stow dir

    // get_rel_path_from_arg
    // output:
    //   - string, representing some relative file path

    // get_current_dir
    // output:
//   - string, representing the current directory

    // get_absolute
    // input:
    //   - r: representing a file path relative to the current directory
    //   - c: representing the current directory
    // output:
    //   - string, absolute path to file directory

    // get_path_p_rel_t
    // input: 
    //   - t: string, absolute path to target
    //   - p: string, absolute path to dir/file 
    // output:
    //   - o: Option<string>, representing the portion of p in t

    // enum MoveRes
    //   Ok, file successfully *moved*
    //   Conflict(String), file already exists
    //   Other, io error

    // move_source_to_target_rel
    // input:
    //   - p: string, absolute path to dir/file
    //   - s: string, absolute path to stow dir
    //   - r: string, relative path to stow dir
    // output:
    //   - MoveRes, representing sucess or failure
    
    // stow
    // runs stow
    // input:
    //   - s: string, absolute path to stow dir
    //   - t: string, absolute path to target dir
}

fn get_path_p_rel_t () {
}
