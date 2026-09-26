use syn::{Item};

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub enum SynItem {
    Function(MyItemFn),
    Struct(MyItemStruct),
    Enum(MyItemEnum),
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub struct MyItemFn {
    pub ident: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub struct MyItemStruct {
    pub ident: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Hash, PartialOrd, Ord, serde::Serialize, serde::Deserialize)]
pub struct MyItemEnum {
    pub ident: String,
}

pub trait Parsable {
    fn parse_from_str(s: &str) -> Result<Self, syn::Error> where Self: Sized;
}

impl Parsable for SynItem {
    fn parse_from_str(s: &str) -> Result<Self, syn::Error> {
        let item: Item = syn::parse_str(s)?;
        match item {
            Item::Fn(func) => {
                let my_func = MyItemFn {
                    ident: func.sig.ident.to_string(),
                };
                Ok(SynItem::Function(my_func))
            }
            Item::Struct(s) => {
                let my_struct = MyItemStruct {
                    ident: s.ident.to_string(),
                };
                Ok(SynItem::Struct(my_struct))
            }
            Item::Enum(e) => {
                let my_enum = MyItemEnum {
                    ident: e.ident.to_string(),
                };
                Ok(SynItem::Enum(my_enum))
            }
            _ => {
                Err(syn::Error::new(
                    proc_macro2::Span::call_site(),
                    "Unsupported item type",
                ))
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_parses_a_function() {
        let code = "fn my_func() -> bool { true }";
        let parsed = SynItem::parse_from_str(code);
        assert!(parsed.is_ok());
        match parsed.unwrap() {
            SynItem::Function(f) => {
                assert_eq!(f.ident, "my_func");
            }
            _ => panic!("Expected a function"),
        }
    }

    #[test]
    fn it_parses_a_struct() {
        let code = "struct MyStruct { field: u32 }";
        let parsed = SynItem::parse_from_str(code);
        assert!(parsed.is_ok());
        match parsed.unwrap() {
            SynItem::Struct(s) => {
                assert_eq!(s.ident, "MyStruct");
            }
            _ => panic!("Expected a struct"),
        }
    }

    #[test]
    fn it_parses_an_enum() {
        let code = "enum MyEnum { Variant1, Variant2 }";
        let parsed = SynItem::parse_from_str(code);
        assert!(parsed.is_ok());
        match parsed.unwrap() {
            SynItem::Enum(e) => {
                assert_eq!(e.ident, "MyEnum");
            }
            _ => panic!("Expected an enum"),
        }
    }

    #[test]
    fn it_fails_on_unsupported_type() {
        let code = "use std::collections::HashMap;";
        let parsed = SynItem::parse_from_str(code);
        assert!(parsed.is_err());
    }
}