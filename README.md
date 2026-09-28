# Simple AWS Cloud Website Launcher

This project is an automated tool that sets up a secure website on Amazon Web Services (AWS) from scratch with just a few terminal commands. 

Instead of clicking through the AWS console to set up servers, firewalls, and websites manually, this project handles everything automatically using code.

## 🚀 What This Project Does

1. **Builds the Server:** It automatically talks to AWS and rents a secure computer (EC2 server) and sets up the security firewall.
2. **Installs the Website:** It logs into that new computer, installs the **Nginx web server software**, and launches a simple welcome webpage.
3. **Generates Keys:** It securely creates the digital keys needed to access the server and keeps them hidden from the public.

---

## 🛠️ How to Use It

### 1. Setup Your AWS Account
Make sure you have your AWS account keys configured on your computer:
```bash
aws configure
```

### 2. Launch the Cloud Server
Run these commands to build the server hardware in the cloud:
```bash
terraform init
terraform plan 
terraform apply -auto-approve
```
*This will automatically create a file called `hosts.ini` and a security key inside your folder.*

### 3. Install the Website Software
Run this command to tell the server to install Nginx and go live:
```bash
ansible-playbook -i hosts.ini playbook.yml
```

Once finished, open your server's Public IP address in any web browser to see your live website!

---

## 🧩 Troubleshooting: Common Mistakes & Fixes

### The "Permission Denied" Username Trap
When setting up this project, you might run into an error that says: `Permission denied (publickey)`. It looks like a password or security key failure, but it is actually a **username mix-up**.

*   **The Problem:** AWS gives different names to its computers depending on the operating system system they run. If you use an **Amazon Linux** computer but tell your code to log in as **`ubuntu`**, AWS will instantly lock you out and deny permission.
*   **The Fix:** Change the login username in your `hosts.ini` configuration file from `ubuntu` to **`ec2-user`**. Once the username matches the Amazon Linux operating system, the system connects perfectly.

---

## 🔒 Security Note
Your private keys (`.pem`) and tracking files are automatically hidden by our security filters. They will never be uploaded to GitHub.

