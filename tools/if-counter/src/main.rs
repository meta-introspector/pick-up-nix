use lang_c::driver::parse;
use lang_c::visit::{self, Visit};
use std::env;
use std::fs;

struct IfVisitor {
    nested_if_count: usize,
    // Stack to track if we are inside an if statement's body
    if_nest_level: usize,
}

impl IfVisitor {
    fn new() -> Self {
        IfVisitor {
            nested_if_count: 0,
            if_nest_level: 0,
        }
    }
}

impl<'ast> Visit<'ast> for IfVisitor {
    fn visit_if_statement(&mut self, if_statement: &'ast lang_c::ast::IfStatement) {
        // If we are already inside an if, this one is nested.
        if self.if_nest_level > 0 {
            self.nested_if_count += 1;
        }

        // Increment nesting level for the body of this if statement.
        self.if_nest_level += 1;
        // Continue traversal into the `then` body.
        visit::walk_statement(self, &if_statement.then_statement);
        // After visiting the `then` body, decrement the level.
        self.if_nest_level -= 1;

        // The `else` part is not considered nested in the same way, 
        // but we still need to traverse it to find other ifs.
        if let Some(else_statement) = &if_statement.else_statement {
            visit::walk_statement(self, else_statement);
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: if-counter <path-to-c-file>");
        return;
    }

    let file_path = &args[1];
    let content = match fs::read_to_string(file_path) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("Failed to read file {}: {}", file_path, e);
            return;
        }
    };

    let parse_result = parse(&content);

    match parse_result {
        Ok(parse) => {
            let mut visitor = IfVisitor::new();
            visitor.visit_translation_unit(&parse.unit);
            println!("Analysis for: {}", file_path);
            println!("  - Estimated nested 'if' statements: {}", visitor.nested_if_count);
        }
        Err(e) => {
            eprintln!("Failed to parse C file: {:?}", e);
        }
    }
}