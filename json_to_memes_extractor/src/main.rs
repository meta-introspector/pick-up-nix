use serde::Deserialize;
use std::fs;
use std::io::{self, Write};
use std::path::Path;

#[derive(Deserialize, Debug)]
struct Ticket {
    id: u64,
    title: String,
    body: String,
    html_url: String,
    created_at: String,
    // Add other fields if necessary, but these seem sufficient for a "meme"
}

fn main() -> io::Result<()> {
    let base_path = Path::new("/data/data/com.termux.nix/files/home/pick-up-nix/");
    let output_dir = base_path.join("docs/memes/extracted_tickets/");

    // Ensure the output directory exists
    fs::create_dir_all(&output_dir)?;

    let metameme_path = base_path.join("vendor/quasi-meta-meme/data/metameme.json");
    let solfunmeme_path = base_path.join("vendor/quasi-meta-meme/data/solfunmeme.json");

    process_concatenated_json_file(&metameme_path, &output_dir)?;
    process_concatenated_json_file(&solfunmeme_path, &output_dir)?;

    println!("Successfully extracted JSON tickets to Markdown memes.");
    Ok(())
}

fn process_concatenated_json_file(file_path: &Path, output_dir: &Path) -> io::Result<()> {
    let json_content = fs::read_to_string(file_path)?;

    // Split the content into individual JSON objects
    // This assumes each JSON object is separated by "}\n{"
    let parts: Vec<&str> = json_content.split("}\n{").collect();

    for (i, part) in parts.iter().enumerate() {
        let mut json_obj_str = part.to_string();
        if i > 0 {
            json_obj_str = "{".to_string() + &json_obj_str;
        }
        if i < parts.len() - 1 {
            json_obj_str = json_obj_str + "}";
        }

        // Attempt to deserialize each part as a single Ticket
        match serde_json::from_str::<Ticket>(&json_obj_str) {
            Ok(ticket) => {
                let mut sanitized_title = ticket.title.replace(|c: char| !c.is_alphanumeric() && c != ' ', "");
                // Further sanitize for common filename issues and truncate
                sanitized_title = sanitized_title.replace(&['/', '\\', ':', '*', '?', '"', '<', '>', '|'][..], "");
                sanitized_title = sanitized_title.trim().replace(' ', "_");

                // Truncate filename to avoid OS limits (e.g., 255 characters)
                // Leaving room for ID, underscore, and .md extension
                let max_title_len = 200;
                if sanitized_title.len() > max_title_len {
                    sanitized_title = sanitized_title[..max_title_len].to_string();
                }

                let filename = format!("{}_{}.md", ticket.id, sanitized_title);
                let output_file_path = output_dir.join(filename);

                let markdown_content = format!(
                    "# {}

**ID:** {}
**Created At:** {}
**Source:** {}

---

{}",
                    ticket.title, ticket.id, ticket.created_at, ticket.html_url, ticket.body
                );

                let mut file = fs::File::create(&output_file_path)?;
                file.write_all(markdown_content.as_bytes())?;
                println!("Created: {}", output_file_path.display());
            }
            Err(e) => {
                eprintln!("Error parsing JSON object from {}: {}", file_path.display(), e);
                eprintln!("Problematic JSON part: {}", json_obj_str);
            }
        }
    }
    Ok(())
}
