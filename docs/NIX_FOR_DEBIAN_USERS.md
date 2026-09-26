# Nix-on-Droid Guide for Debian Users

Welcome to Nix-on-Droid! This guide will help you, a Debian user, understand the key concepts of this setup.

## 1. Introduction

*   **Nix:** A powerful package manager that makes package management reliable and reproducible.
*   **Nixpkgs:** A vast collection of packages that can be installed with Nix. It's like the Debian repository, but much larger.
*   **Nix-on-Droid:** A project that allows you to use Nix to manage your environment on Android, running on top of Termux.
*   **Flakes:** A new feature in Nix that improves reproducibility and composability of Nix-based projects.

## 2. Declarative Package Management

With `apt`, you install packages imperatively. For example, `apt install git`. This modifies your system state directly.

Nix works differently. You declare the packages you want in a configuration file (`nix-on-droid.nix`). Then, you run a command to make your system match the configuration. This is called declarative package management.

**Key benefits:**

*   **Reproducibility:** You can recreate the same environment on any machine by just copying the configuration file.
*   **Atomic Upgrades:** Upgrades are atomic, meaning they either complete successfully or not at all. No more broken states.
*   **Rollbacks:** If an upgrade goes wrong, you can easily roll back to the previous state.

## 3. `apt` vs. `nix-on-droid`

| Debian (`apt`)                  | Nix-on-Droid (`nix-on-droid`) |
| ------------------------------- | ----------------------------- |
| `apt update && apt upgrade`     | `nix-on-droid switch`         |
| `apt install <package>`         | Add `<package>` to `nix-on-droid.nix` and run `nix-on-droid switch` |
| `apt remove <package>`          | Remove `<package>` from `nix-on-droid.nix` and run `nix-on-droid switch` |
| `apt search <package>`          | `nix search nixpkgs <package>` |

## 4. Finding Packages

To find packages, you can use the Nix search website: [https://search.nixos.org/packages](https://search.nixos.org/packages)

Or you can use the command line:

```bash
nix search nixpkgs <query>
```

For example, to search for `htop`:

```bash
nix search nixpkgs htop
```

## 5. Configuration Files

*   `~/.config/nix-on-droid/flake.nix`: This is the entry point for your configuration. It defines the inputs, such as the version of `nixpkgs` to use. You usually don't need to edit this file.
*   `~/.config/nix-on-droid/nix-on-droid.nix`: This is where you define the packages you want to install. You will edit this file most of the time.

The `environment.packages` list in `nix-on-droid.nix` is where you add the packages you want.

## 6. Applying Changes

After you modify `nix-on-droid.nix`, you need to apply the changes. To do this, run:

```bash
nix-on-droid switch
```

This command will:

1.  **Build** the new configuration.
2.  **Install** any new packages.
3.  **Create** a new "generation" of your environment.

## 7. Generations and Rollbacks

Every time you run `nix-on-droid switch`, a new generation is created. This is a snapshot of your environment at that point in time.

You can list the available generations with:

```bash
nix-env --list-generations
```

If something goes wrong with a new generation, you can easily roll back to a previous one:

```bash
nix-env --rollback
```

This will switch you back to the previous generation, effectively undoing the last `nix-on-droid switch`.

We hope this guide helps you get started with Nix-on-Droid!

## 8. Essential Diagnostic Tools for Android

For effective debugging and system analysis on your Android device, a set of essential diagnostic tools has been integrated into the Nix-on-Droid flake configuration. These tools provide deep insights into system behavior, process execution, and network activity.

### 8.1 Included Tools

The following tools are now available in your Nix-on-Droid environment:

*   **`strace`**: Traces system calls and signals. Invaluable for understanding how programs interact with the kernel.
*   **`ltrace`**: Traces library calls made by dynamically linked programs. Useful for debugging issues related to shared libraries.
*   **`htop`**: An interactive process viewer, offering a more user-friendly and feature-rich alternative to `top`.
*   **`iotop`**: Monitors disk I/O usage by processes or threads. Helps identify applications that are heavily using the disk.
*   **`iftop`**: Displays bandwidth usage on an interface. Useful for monitoring network activity.
*   **`nettools`**: A collection of fundamental networking utilities, including `ifconfig`, `netstat`, `route`, etc.
*   **`procps`**: A suite of utilities for controlling and monitoring processes, including `top`, `ps`, `free`, `uptime`, and `kill`.

### 8.2 How to Access

These tools are automatically included in your Android environment once you rebuild your Nix-on-Droid configuration after the flake update. You can then simply run them from your terminal.

