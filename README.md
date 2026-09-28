# Infrastructure-as-Code & Automated Web Architecture Pipeline

An enterprise-grade automation stack designed to orchestrate immutable cloud infrastructure on **Amazon Web Services (AWS)** using **Terraform (HCLv2)** and execute stateless server provisioning using **Ansible (YAML)**.

This framework enforces a clean separation of concerns by decoupling underlying resource provisioning from the software configuration lifecycle. It deploys a high-performance **Nginx Web Engine** cluster on enterprise-grade **Amazon Linux** nodes.

---

## 🏗️ System Pipeline Architecture

```text
  [ Local DevOps Control Node ]
               │
               ├── 1. Run "terraform apply" ──> [ AWS Cloud API Engines ]
               │                                      │
               │                                (Provisions VPC / Security Group / EC2)
               │                                      │
               ├── 2. Auto-Generates ────────────────> V
               │      "hosts.ini" & Key-pairs     [ AWS EC2 Compute Node ]
               │                                  (OS: Amazon Linux Native)
               V                                      │
               └── 3. Run "ansible-playbook" ─────────┼── Core System Updates (YUM Engine)
                      (Executes Over SSH Tunnel)      ├── Nginx Web Engine Installation
                                                      └── Stateful Web Content Deployment
```

### Core Architectural Layers

*   **Infrastructure Provisioning (Terraform):**
    *   **Provider Runtime:** Explicit cloud api abstraction layer targeting your globally mapped IAM principals.
    *   **Cryptographic Layer:** Programmatic orchestration of an ephemeral `tls_private_key` generation block generating asymmetric RSA-4096 credentials local-side.
    *   **Network Security Profiles:** Stateful Security Groups enforcing a highly restrictive ingress perimeter (TCP `22` for secured remote administration; TCP `80` for standard HTTP routing).
    *   **Compute Fabric:** High-performance Elastic Compute Cloud (EC2) compute nodes configured to boot native **Amazon Linux** kernels.
*   **Configuration Management (Ansible):**
    *   **System Hardening:** Automated update arrays checking, catching, and applying latest dependency upgrades via the `yum` core engine.
    *   **Web Engine Core:** Native provisioning of a scalable, event-driven Nginx deployment wrapper.
    *   **Asset Management:** Dynamic environment state updates mapping index landing parameters straight to the operational web root (`/usr/share/nginx/html/`).

---

## 🛠️ Control Node Configuration

Ensure your local terminal session has the required toolchains active prior to initiating the pipeline sequences.

### 1. Engine Installation
```bash
# Ubuntu / Debian Systems
sudo apt-get update && sudo apt-get install terraform ansible awscli -y
```

### 2. AWS Profile Authentication
Bind your programmatic IAM access vectors securely to your native machine environment variables:
```bash
aws configure
```
*Provide your specific structural `AWS Access Key ID`, `AWS Secret Access Key`, and confirm your standard target operational availability zone (e.g., `us-west-1`).*

---

## 🚀 The Execution Run-Sequence

The setup implements a **decoupled hand-off pipeline architecture**. Terraform provisions the hardware layer and dynamically writes a functional `hosts.ini` layout right into your workspace context for immediate consumption by Ansible.

### Phase 1: Hardware State Provisioning
Initialize structural plugins, evaluate configuration schemas, and commit the cloud target footprint:
```bash
# Initialize local runtime state and acquire cloud backend providers
terraform init

# Compute declarative delta matrices safely against live API endpoints
terraform plan

# Execute the allocation strategy and lock down state definitions
terraform apply -auto-approve
```

### Phase 2: Configuration & Application Setup
Once the infrastructure state drops valid public IP pointers into the directory, trigger your playbook to baseline the operating system:
```bash
# Run tasks to update system cores, install Nginx, and launch target landing contexts
ansible-playbook -i hosts.ini playbook.yml
```

---

## ⚠️ Known Production Gotchas & Technical Deflections

*   **The Asymmetric Publickey Rejection (`Permission denied`):**
    This infrastructure stack utilizes highly streamlined Amazon Linux configurations. Standard connection sequences leveraging typical `ubuntu` or `root` account profiles will trigger instant OpenSSH public key validation failures. Network connections must route strictly through the designated root principal handler: `ansible_user=ec2-user`.
*   **Post-Quantum Cryptography Warnings Logs Noise:**
    Modern operations terminals operating OpenSSH 9.8+ suites will output local warnings due to older transit key structures inside native EC2 engines. Strict automation argument flags (`-o WarnWeakCrypto=no`) are pre-seeded straight into your tracking `hosts.ini` mapping parameters to eliminate log noise and stop continuous integration parser breakages.

