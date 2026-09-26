// This module defines enums related to system configuration files typically found in /etc.

#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Etc {
    Apache2(Apache2),
    Nagios(Nagios),
    Nagios4(Nagios4),
}

/// Represents Apache2 configuration files.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Apache2 {
    ConfAvailable,
    ConfEnabled,
    ModsAvailable,
    ModsEnabled,
    SitesAvailable,
    SitesEnabled,
    Apache2Conf,
    Envvars,
    Magic,
    PortsConf,
}

/// Represents Nagios configuration files.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Nagios {
    NrpeCfg,
}

/// Represents Nagios4 configuration files.
#[derive(Debug, Clone, PartialEq, Eq, Hash, serde::Serialize, serde::Deserialize, PartialOrd, Ord)]
pub enum Nagios4 {
    ConfD,
    Objects,
    Stylesheets,
    Apache2Conf,
    CgiCfg,
    NagiosCfg,
}