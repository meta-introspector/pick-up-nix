use std::fs::File;
use std::io::{self, BufReader, BufRead};
use std::collections::HashSet;
use regex::Regex;

fn main() -> io::Result<()> {
    let file_path = "/data/data/com.termux.nix/files/home/pick-up-nix2/file.txt";
    let file = File::open(file_path)?;
    let reader = BufReader::new(file);

    let mut unique_extensions: HashSet<String> = HashSet::new();
    let mut unique_tokens: HashSet<String> = HashSet::new();

    let token_re = Regex::new(r"[a-zA-Z0-9_]+").unwrap();

    for line_result in reader.lines() {
        let line = line_result?;

        // Extract file extensions
        if let Some(dot_index) = line.rfind('.') {
            let potential_extension = &line[dot_index..];
            // Basic check to ensure it looks like an extension (e.g., not just a dot)
            if potential_extension.len() > 1 && !potential_extension.contains('/') && !potential_extension.contains('\\') {
                unique_extensions.insert(potential_extension.to_lowercase());
            }
        }

        // Extract tokens
        for mat in token_re.find_iter(&line) {
            unique_tokens.insert(mat.as_str().to_lowercase());
        }
    }

    println!("Unique File Extensions:");
    for ext in unique_extensions {
        println!("{}", ext);
    }

    println!("\nUnique Tokens:");
    for token in unique_tokens {
        println!("{}", token);
    }

    Ok(())
}