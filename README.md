# 🐳 Hosting Multiple Static Websites with Docker and Nginx on AWS EC2

This project demonstrates how I deployed **multiple static websites using Docker and Nginx** on a single AWS EC2 instance. Each website runs in its own Docker container, listens on a different port, and serves its own HTML content.

---

## 🚀 Project Goal

I wanted to learn how to:
- Use **Docker** to host web content
- Run **multiple websites** on a single EC2 instance
- Understand **port mapping**, **file copying**, and **container management**
- Tackle **real-world issues** like permission errors, file updates, and container behavior

---

## 🖥️ Websites Deployed

| Site        | Container Name | Port   | HTML File        | Example URL                        |
|-------------|----------------|--------|------------------|------------------------------------|
| HRMS        | `hrms`         | 9001   | `index.html`     | `http://<EC2-IP>:9001`             |
| Website     | `website`      | 9002   | `index2.html`    | `http://<EC2-IP>:9002`             |
| Portfolio   | `portfolio`    | 9003   | `portfolio.html` | `http://<EC2-IP>:9003`             |

> Each container runs the official Nginx image and serves a different static HTML file.

---

## 📚 What I Learned

- How to install and run Docker on AWS EC2
- Managing containers: `run`, `ps`, `exec`, `cp`, `rm`, etc.
- Serving custom HTML with Nginx using `docker cp`
- Fixing PEM file permission errors on Windows for SSH access
- Understanding Nginx default behavior and how to override it
- Dealing with browser caching and Docker container file persistence

---

## ⚠️ Real-World Problems I Faced

### 🔐 Problem 1: SSH Key Error on Windows  
> **"UNPROTECTED PRIVATE KEY FILE!"**

**Fix:** Removed inherited permissions and restricted access to the `.pem` file using PowerShell.

---

### 🌐 Problem 2: Website Didn't Show My HTML  
> Nginx kept showing the **default welcome page**

**Fix:** I realized I had copied the file as `index2.html` instead of replacing `index.html`. Renamed the file inside the container using:

> bash
docker exec -it container-name /bin/bash
mv /usr/share/nginx/html/index2.html /usr/share/nginx/html/index.html

### 🔁 Problem 3: File Updates Not Reflected**
I edited my HTML file, but the website didn't change.

 **Fix:** Editing files on the host doesn't update what's inside a container. Used docker cp again to recopy and replace the file.

### 🧰 Tech Stack
> AWS EC2 (Amazon Linux 2)
> Docker
> Nginx (official image)
> Static HTML pages

---

### 🗂️ Project Files

├── index.html               # HRMS site

├── index2.html              # Website

├── portfolio.html           # Portfolio

├── run-containers.sh        # Script to set up all containers

├── commands-history.txt     # Full list of all commands I ran

└── README.md                # This file


---

### 🧪 How To Try This Yourself
   
 ## ✅ 1. Launch EC2 Instance

> Use Amazon Linux 2

> Allow inbound ports:  9001, 9002, 9003

## ✅ 2. SSH into EC2

> ssh -i "your-key.pem" ec2-user@<your-ec2-ip>

## ✅ 3. Install Docker

> sudo yum update -y

> sudo yum install docker -y

> sudo systemctl enable --now docker

> sudo usermod -aG docker ec2-user

> exit   (log back in again to apply group changes)

## ✅ 4. Clone This Repo

> git clone https://github.com/Harshal0042/docker-multi-nginx-site.git
 
> cd docker-multi-nginx-site

> chmod +x run-containers.sh

## ✅ 5. Run Setup Script

> ./run-containers.sh  (check repo for the script)

## 💻 Access Your Websites

 Open these in your browser (replace <your-ec2-ip>):

> http://<your-ec2-ip>:9001 → HRMS

> http://<your-ec2-ip>:9002 → Website

> http://<your-ec2-ip>:9003 → Portfolio
