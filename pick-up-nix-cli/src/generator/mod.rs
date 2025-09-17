use crate::events::{SystemEvent, EventType, EventData, EventContext};
use rstrace::trace;
use rstrace::syscall::Syscall;
use std::time::{SystemTime, UNIX_EPOCH};

pub struct StraceGenerator;

impl StraceGenerator {
    pub fn new() -> Self {
        StraceGenerator {}
    }

    pub fn trace_command(&self, command: &str, args: &[&str]) -> Result<Vec<SystemEvent>, String> {
        println!("Tracing command: {} {}", command, args.join(" "));

        let syscalls = trace(command, args)
            .map_err(|e| format!("rstrace error: {}", e))?;

        let mut events: Vec<SystemEvent> = Vec::new();

        for syscall in syscalls {
            let timestamp = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .map_err(|e| format!("Failed to get timestamp: {}", e))?
                .as_nanos() as u64;

            let event_type = match syscall.name.as_str() {
                "openat" | "open" => EventType::FileOpen,
                "close" => EventType::FileClose,
                "read" | "write" => EventType::NetRecv, // Simplified for now, will refine later
                _ => EventType::SyscallEntry, // Default for other syscalls
            };

            let event_data = EventData::Syscall {
                number: syscall.id as i64,
                args: syscall.args.iter().map(|&x| x as u64).collect(),
                ret: syscall.ret.map(|x| x as i64),
            };

            events.push(SystemEvent {
                timestamp,
                pid: syscall.pid as u32,
                tid: syscall.pid as u32, // rstrace doesn't provide tid directly, using pid for now
                event_type,
                data: event_data,
                context: EventContext::default(),
            });
        }

        Ok(events)
    }
}
