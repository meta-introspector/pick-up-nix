use gix::object::Kind;
use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, Serialize, Deserialize)]
pub enum GitItem {
    Commit(MyCommit),
    Tree(MyTree),
    Blob(MyBlob),
    Tag(MyTag),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, Serialize, Deserialize)]
pub struct MyCommit {
    pub id: String,
    pub message: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, Serialize, Deserialize)]
pub struct MyTree {
    pub id: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, Serialize, Deserialize)]
pub struct MyBlob {
    pub id: String,
    pub size: u64,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, Serialize, Deserialize)]
pub struct MyTag {
    pub id: String,
    pub target: String,
}

pub trait Readable {
    fn read_from_repo(repo_path: &str, oid: &str) -> Result<Self, Box<dyn std::error::Error>> where Self: Sized;
}

impl Readable for GitItem {
    fn read_from_repo(repo_path: &str, oid: &str) -> Result<Self, Box<dyn std::error::Error>> {
        let repo = gix::open(repo_path)?;
        let oid = gix::ObjectId::from_hex(oid.as_bytes())?;
        let object = repo.find_object(oid)?;

        match object.kind {
            Kind::Commit => {
                let commit = object.into_commit()?;
                let my_commit = MyCommit {
                    id: commit.id.to_string(),
                    message: commit.message_raw()?.to_string(),
                };
                Ok(GitItem::Commit(my_commit))
            }
            Kind::Tree => {
                let tree = object.into_tree()?;
                let my_tree = MyTree {
                    id: tree.id.to_string(),
                };
                Ok(GitItem::Tree(my_tree))
            }
            Kind::Blob => {
                let blob = object.into_blob()?;
                let my_blob = MyBlob {
                    id: blob.id.to_string(),
                    size: blob.data.len() as u64,
                };
                Ok(GitItem::Blob(my_blob))
            }
            Kind::Tag => {
                let tag = object.into_tag()?;
                let my_tag = MyTag {
                    id: tag.id.to_string(),
                    target: tag.target()?.to_string(),
                };
                Ok(GitItem::Tag(my_tag))
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use gix::prelude::*;
    use tempfile::TempDir;

    fn create_test_repo_with_blob() -> (TempDir, String) {
        let dir = tempfile::tempdir().unwrap();
        let repo_path = dir.path();
        let mut repo = gix::init(repo_path).unwrap();
        
        let blob_id = repo.write_blob("hello world").unwrap();
        
        (dir, blob_id.to_string())
    }

    #[test]
    fn it_reads_a_blob() {
        let (dir, blob_id_str) = create_test_repo_with_blob();
        
        let item = GitItem::read_from_repo(dir.path().to_str().unwrap(), &blob_id_str).unwrap();
        match item {
            GitItem::Blob(b) => {
                assert_eq!(b.id, blob_id_str);
                assert_eq!(b.size, 11);
            }
            _ => panic!("Expected a blob"),
        }
    }
}