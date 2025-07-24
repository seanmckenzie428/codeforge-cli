# Codeforge

Codeforge is a Swift-based command-line tool designed to generate random, unique codes and save them in a CSV file. It is ideal for tasks such as creating promo codes or other bulk code generation needs. Codeforge is highly efficient, capable of generating up to 1,000,000 unique codes in just 3 seconds. This guide will walk you through the steps to install and run Codeforge on your system.

---

## Installation

Follow these steps to install Codeforge:

1. **Download the Prebuilt Binary**:
   Visit the [Codeforge Releases Page](https://github.com/seanmckenzie428/codeforge-cli/releases) on GitHub and download the latest release for your operating system.

2. **Install the Executable**:
   After downloading, move the binary to a directory in your PATH for easier access:

   ```bash
   mv codeforge /usr/local/bin/codeforge
   ```

   **Note for macOS Users**: You might need to grant execute permissions:

   ```bash
   chmod +x /usr/local/bin/codeforge
   ```

---

## Running Codeforge

Once installed, you can run Codeforge from the terminal:

```bash
codeforge
```

The program will prompt you for options and parameters to execute its functionality.

---

## Troubleshooting

### macOS Security Permissions

If you encounter a security warning when running the program (e.g., "codeforge cannot be opened because the developer cannot be verified"), follow these steps:

1. Open **System Preferences** > **Security & Privacy**.
2. Under the **General** tab, you should see a message about `codeforge`. Click **Allow Anyway**.
3. Re-run the program:
   ```bash
   codeforge
   ```

### Linux Permissions

If you encounter a "Permission denied" error, ensure the executable has the correct permissions:

```bash
chmod +x /usr/local/bin/codeforge
```

---

## Uninstallation

To remove Codeforge from your system, delete the executable:

```bash
rm /usr/local/bin/codeforge
```

---

## Optional: Compile from Source

If you prefer to build Codeforge yourself, clone the repository and use Swift Package Manager (SPM) to build the project:

### Prerequisites

Before you begin, ensure you have the following installed on your system:

1. **Swift**: Version 6.0 or higher. You can check your Swift version by running:

   ```bash
   swift --version
   ```

   If Swift is not installed, download it from [Swift.org](https://swift.org/download/).

2. **Git**: To clone the repository. Verify installation with:

   ```bash
   git --version
   ```

3. **macOS or Linux**: This guide assumes you are using macOS or a Linux distribution. It should compile just fine on a Windows machine, but I have not tested it.

### Instructions

```bash
git clone https://github.com/seanmckenzie428/codeforge-cli.git
cd codeforge
swift build -c release
cp .build/release/codeforge /usr/local/bin/codeforge
```

For further assistance, please refer to the [Swift Documentation](https://swift.org/documentation/) or open an issue on the project's GitHub repository.
