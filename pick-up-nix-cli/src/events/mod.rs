use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SystemEvent {
    pub timestamp: u64,         // Nanoseconds since epoch
    pub pid: u32,               // Process ID
    pub tid: u32,               // Thread ID
    pub event_type: EventType,  // Enum: SyscallEntry, SyscallExit, FileOpen, NetPacket, etc.
    pub data: EventData,        // Enum holding event-specific data
    pub context: EventContext,  // Optional: Stack trace, CPU ID, etc.
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum EventType {
    SyscallEntry,
    SyscallExit,
    FileOpen,
    FileClose,
    NetRecv,
    NetSend,
    ProcessFork,
    ProcessExec,
    // ... other relevant event types
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum EventData {
    Syscall {
        number: i64,
        args: Vec<u64>, // Raw arguments
        ret: Option<i64>, // Return value for SyscallExit
    },
    File {
        path: String,
        flags: Option<i32>,
        mode: Option<u32>,
    },
    Network {
        src_ip: String,
        dst_ip: String,
        src_port: u16,
        dst_port: u16,
        payload_len: usize,
        // ... potentially payload snippet
    },
    // ... other event-specific data
}

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct EventContext {
    pub cpu_id: Option<u32>,
    pub stack_trace: Option<Vec<String>>, // Symbolic stack trace
    // ... other contextual information
}
