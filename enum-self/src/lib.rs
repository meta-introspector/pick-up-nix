pub mod project_items;
pub mod project_aspects;
pub mod config;
pub mod configurations;
pub mod documentation;
pub mod enum_self;
pub mod etc;
pub mod experiments;
pub mod file_analyzer;
pub mod github;
pub mod home;
pub mod json_to_memes_extractor;
pub mod logs;
pub mod manifests;
pub mod memetic_code;
pub mod new;
pub mod nix_config;
pub mod nixpacks;
pub mod packages;
pub mod pick_up_nix_cli;
pub mod prompts;
pub mod qa;
pub mod source;
pub mod src_dir;
pub mod submodule_flakes;
pub mod task;
pub mod tasks;
pub mod test_flake;
pub mod tools;
pub mod vendor;
pub mod wrappers;

#[cfg(test)]
mod tests {
    use super::*;
    use crate::project_items::project_item::{ProjectItem, CodeAndDevelopment};
    use crate::file_analyzer::{FileAnalyzer, FileAnalyzerSrc};
    use crate::enum_self::{EnumSelf, EnumSelfSrc, LibRs, TestsModule};

    #[test]
    fn test_project_item_serialization() {
        let item = ProjectItem::CodeAndDevelopment(CodeAndDevelopment::FileAnalyzer(
            FileAnalyzer::Src(FileAnalyzerSrc::MainRs),
        ));

        let serialized = serde_json::to_string_pretty(&item).unwrap();

        let expected = r#"{
  "CodeAndDevelopment": {
    "FileAnalyzer": {
      "Src": "MainRs"
    }
  }
}"#;
        assert_eq!(serialized, expected);
    }

    #[test]
    fn test_self_description() {
        // This test now describes the `tests` module within `lib.rs`.
        let item = ProjectItem::CodeAndDevelopment(CodeAndDevelopment::EnumSelf(
            EnumSelf::Src(EnumSelfSrc::LibRs(
                LibRs::Tests(TestsModule::TestSelfDescription) // It describes itself.
            ))
        ));

        let serialized = serde_json::to_string_pretty(&item).unwrap();
        let expected = r#"{
  "CodeAndDevelopment": {
    "EnumSelf": {
      "Src": {
        "LibRs": {
          "Tests": "TestSelfDescription"
        }
      }
    }
  }
}"#;
        assert_eq!(serialized, expected);
    }

    #[test]
    fn test_description_of_self_description_test() {
        // This test describes the test above.
        let item = ProjectItem::CodeAndDevelopment(CodeAndDevelopment::EnumSelf(
            EnumSelf::Src(EnumSelfSrc::LibRs(
                LibRs::Tests(TestsModule::TestDescriptionOfSelfDescriptionTest)
            ))
        ));

        let serialized = serde_json::to_string_pretty(&item).unwrap();

        let expected = r#"{
  "CodeAndDevelopment": {
    "EnumSelf": {
      "Src": {
        "LibRs": {
          "Tests": "TestDescriptionOfSelfDescriptionTest"
        }
      }
    }
  }
}"#;
        assert_eq!(serialized, expected);
    }

    #[test]
    fn test_syn_wrapper_integration() {
        use crate::wrappers::WrappedItem;
        use syn_wrapper::{Parsable, SynItem};

        let code = "fn my_func() {}";
        let parsed = SynItem::parse_from_str(code).unwrap();
        let item = ProjectItem::Wrapped(WrappedItem::Syn(parsed));

        let serialized = serde_json::to_string_pretty(&item).unwrap();
        let expected = r#"{
  "Wrapped": {
    "Syn": {
      "Function": {
        "ident": "my_func"
      }
    }
  }
}"#;
        assert_eq!(serialized, expected);
    }
}