
# TheScriptNinja - A Mix of both Serious & Fun Scripting

Welcome to **TheScriptNinja**, where serious scripting meets a bit of ocational fun! This repository is a collection of PowerShell, Bash, Python, Batch, CMD and various scripts aimed at solving real-world problems, while occasionally adding a little twist of humor and personality among them. Whether you're looking for automation tools, system utilities, or just fun code experiments, you're in the right place (Growing slow but steady).

---

## 🛠️ Features

- **PowerShell**: Scripts for system administration, network management, and automating repetitive tasks.
- **Bash**: Custom Mac & Linux tools, backups, and environment configurations etc.
- **Python**: Miscellaneous Python scripts for various automations and utilities.
- **Batch/CMD**: Old school Windows batch scripting for legacy systems and simplicity, becouse who does not love a small .bat to solve a major problem?.

This repository contains a combination of serious and light-hearted projects. Enjoy and feel free to contribute!

---

## ⚙️ Getting Started

### 1. Clone the Repository

First, clone the repository to your local machine.

```bash
git clone https://github.com/mektigh/TheScriptNinja.git
```

### 2. Prerequisites

- PowerShell (for Windows and macOS)
- Bash (macOS/Linux)
- Python (for Python-based scripts)
- Any terminal with script execution capabilities

### 3. Running Scripts

To run any of the scripts, navigate to the script directory and use the following commands depending on your environment or read the README.md for the script where additional information is added and documented:

#### For PowerShell:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\scriptName.ps1
```

#### For Bash:
```bash
chmod +x scriptName.sh
./scriptName.sh
```

#### For Python:
```bash
python3 scriptName.py
```

---

## ⚠️ Important Information

- This repository is a mix of **serious** and **fun** content. While the scripts may serve legitimate purposes, please review and understand them before running them in production environments.
- **Security Warning**: Avoid using hardcoded credentials. Use environment variables or external configuration files for sensitive data (e.g., API keys).
- Make sure to check and update your dependencies, as some scripts might require external libraries or packages.

---

## 🔧 Tools & Languages

This repository includes the following tools and languages:

- **PowerShell** for Windows automation
- **Bash** for Linux and macOS shell scripting
- **Python** for cross-platform tasks
- **Batch/CMD** for legacy Windows systems

---

## 🛡️ Code Security Best Practices

To ensure the safety and security of your code:

- **Avoid hardcoding sensitive information**: Use environment variables for secrets like API keys, tokens, and passwords.
- **Check dependencies**: Keep all external libraries and dependencies up to date. Consider using tools like `pip`, `npm`, or `composer` for package management.
- **Sanitize user inputs**: Prevent security risks like command injection by validating inputs.
- **Log all critical activities**: Ensure that important actions are logged for auditing and debugging purposes.

---

## 🌍 License

This repository is licensed under the **MIT License**.

Feel free to use, modify, and distribute the scripts as you like. Just don't forget to give credit where it's due!

---

## 📜 To-Do

Here are a few things to expect in future updates:

- More fun, quirky scripts (because who doesn't love a good joke?)
- Cross-platform compatibility improvements
- Enhanced security features and best practices

---

## 🤝 Contributing

I welcome contributions to **TheScriptNinja**! 
If you have a cool idea, script, or fix, feel free to fork the repository and submit a pull request.

### How to contribute:

1. Fork the repository
2. Create a new branch for your feature or fix
3. Write your code or fix
4. Test your changes
5. Submit a pull request with a description of your changes

---

## Useful information

### 📚 How to Implement in Intune, GPO, and Other Environments

#### 🔧 In Intune:

1. Upload the script as a **PowerShell script** under **Devices > Scripts**.
2. Create a new policy and assign it to the target device or user group.
3. Monitor the deployment status via the **Intune dashboard**.

#### 🖥️ Adding to Group Policy:

1. Open **Group Policy Management**.
2. Create a new **GPO**.
3. Under **User Configuration > Windows Settings > Scripts**, add your script.
4. Deploy to the required group of machines.

#### 🖥️ Direct Execution:

If you want to run the script directly via PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\script.ps1
```

For Bash, execute the `.sh` script with `chmod +x` followed by `./script.sh`.

---

## 📞 Contact

If you have any questions or feedback, feel free to reach out via **GitHub Issues** or contact me through the repository's contact page.

---

*Happy scripting and stay ninja!* 🥷🏼
