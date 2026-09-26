
import os
import re

def read_file_content(filepath):
    with open(filepath, 'r') as f:
        return f.read()

def write_chunk(output_dir, filename, content):
    os.makedirs(output_dir, exist_ok=True)
    filepath = os.path.join(output_dir, filename)
    with open(filepath, 'w') as f:
        f.write(content)

def chunk_by_keywords(text, keywords, base_output_dir, filename_prefix="chunk"):
    chunks = []
    current_chunk = []
    chunk_id = 0
    keyword_pattern = re.compile(r'|'.join(re.escape(k) for k in keywords))

    lines = text.splitlines(keepends=True)
    for line in lines:
        match = keyword_pattern.search(line)
        if match:
            if current_chunk:
                chunk_content = "".join(current_chunk)
                chunk_filename = f"{filename_prefix}_{chunk_id}.txt"
                write_chunk(base_output_dir, chunk_filename, chunk_content)
                chunks.append((chunk_filename, chunk_content))
                current_chunk = []
                chunk_id += 1
            current_chunk.append(line)
        else:
            current_chunk.append(line)

    if current_chunk:
        chunk_content = "".join(current_chunk)
        chunk_filename = f"{filename_prefix}_{chunk_id}.txt"
        write_chunk(base_output_dir, chunk_filename, chunk_content)
        chunks.append((chunk_filename, chunk_content))

    return chunks

def chunk_by_file_endings(text, base_output_dir, filename_prefix="file_ending_chunk"):
    chunks = []
    # Common file endings to look for
    file_ending_pattern = re.compile(r'\b\w+\.(rs|nix|md|toml|py|sh|txt|json|lock)\b')
    
    current_chunk = []
    chunk_id = 0
    lines = text.splitlines(keepends=True)

    for line in lines:
        match = file_ending_pattern.search(line)
        if match:
            if current_chunk:
                chunk_content = "".join(current_chunk)
                chunk_filename = f"{filename_prefix}_{chunk_id}.txt"
                write_chunk(base_output_dir, chunk_filename, chunk_content)
                chunks.append((chunk_filename, chunk_content))
                current_chunk = []
                chunk_id += 1
            current_chunk.append(line)
        else:
            current_chunk.append(line)

    if current_chunk:
        chunk_content = "".join(current_chunk)
        chunk_filename = f"{filename_prefix}_{chunk_id}.txt"
        write_chunk(base_output_dir, chunk_filename, chunk_content)
        chunks.append((chunk_filename, chunk_content))
    return chunks


def main():
    file_to_chunk = "/data/data/com.termux.nix/files/home/pick-up-nix2/file.txt"
    output_base_dir = "/data/data/com.termux.nix/files/home/pick-up-nix2/chunks"

    if not os.path.exists(file_to_chunk):
        print(f"Error: File not found at {file_to_chunk}")
        return

    content = read_file_content(file_to_chunk)

    # Overall Top 10 Unique Terms
    overall_keywords = [
        "vendor", "nixpkgs", "pkgs", "external", "rust", "tests", "nix", "name", "rs", "by"
    ]

    # Top 10 Unique Terms (Filtered by 'vendor')
    vendor_filtered_keywords = [
        "vendor", "nixpkgs", "pkgs", "external", "rust", "tests", "nix", "name", "by", "rs"
    ]

    # Initial Keyword-Based Chunking
    print("Performing initial keyword-based chunking...")
    initial_chunks_dir = os.path.join(output_base_dir, "initial_keyword_chunks")
    initial_chunks = chunk_by_keywords(content, overall_keywords, initial_chunks_dir, "overall")
    print(f"Generated {len(initial_chunks)} initial keyword chunks.")

    # Recursive Keyword-Based Chunking for 'vendor' related chunks
    print("Performing recursive keyword-based chunking for 'vendor' related chunks...")
    for filename, chunk_content in initial_chunks:
        if "vendor" in chunk_content:
            vendor_chunk_output_dir = os.path.join(initial_chunks_dir, filename.replace(".txt", "_vendor_subchunks"))
            vendor_subchunks = chunk_by_keywords(chunk_content, vendor_filtered_keywords, vendor_chunk_output_dir, "vendor_sub")
            print(f"  Generated {len(vendor_subchunks)} sub-chunks for {filename}.")

    # File Ending-Based Chunking
    print("Performing file ending-based chunking...")
    file_ending_chunks_dir = os.path.join(output_base_dir, "file_ending_chunks")
    file_ending_chunks = chunk_by_file_endings(content, file_ending_chunks_dir, "file_ending")
    print(f"Generated {len(file_ending_chunks)} file ending chunks.")

    print("Chunking process complete.")

if __name__ == "__main__":
    main()
