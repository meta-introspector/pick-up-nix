use syn_wrapper::SynItem;

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub enum WrappedItem {
    Syn(SynItem),
    // Git(GitItem), etc.
}
