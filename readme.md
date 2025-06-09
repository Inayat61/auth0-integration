# Helloworld Application

This project is a **HelloWorld** application that uses Terraform to deploy both the frontend (a React app) and backend (including Auth0 for authentication and the necessary infrastructure).

## [Live Application](https://d1992ly3dsmie5.cloudfront.net/)

You can visit the live version of the application at the link above.

## Table of Contents

- [Introduction](#introduction)
- [Technology Stack](#technology-stack)
- [Infrastructure Overview](#infrastructure-overview)
- [Authentication](#authentication)
- [Terraform Deployment](#terraform-deployment)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Introduction

The **HelloWorld** application is a full-stack web application deployed using **Terraform**. The frontend is built with **React** and hosted on **Amazon S3**, while **Amazon CloudFront** is used for content delivery. The backend is integrated with **Auth0** for authentication services, and Terraform is used to provision the necessary cloud infrastructure.

## Technology Stack

- **Frontend**: React
- **Backend**: Auth0 (for authentication)
- **Infrastructure**: Terraform (for deployment)
- **Hosting**: Amazon S3 (for static assets), Amazon CloudFront (CDN)

## Infrastructure Overview

The architecture for the application is as follows:

```
Browser --> CloudFront --> S3 --> Auth0
```

### Components

- **Browser**: The user accesses the application through their browser.
- **Amazon CloudFront**: Delivers the static assets for the front-end app, stored in **Amazon S3**.
- **Amazon S3**: Hosts the static files for the React application.
- **Auth0**: Handles user authentication, utilizing a universal login template and managing post-login actions.

## Authentication

This project uses **Auth0** to handle user login and authentication. After logging in through Auth0's **Universal Login** page, users are redirected to the appropriate post-login action, such as accessing the app's dashboard.

### Auth0 Features:

- Universal Login Template
- Post-login actions
- Secure authentication mechanisms

## Terraform Deployment

**Terraform** is used to automate the deployment of the application’s infrastructure. This includes:

- Provisioning an **Amazon S3** bucket to store static files for the React app.
- Setting up **Amazon CloudFront** for CDN distribution.
- Configuring **Auth0** for user authentication.
- Managing the necessary DNS configurations and permissions.

### How to Deploy Using Terraform:

1. Install **Terraform** on your machine if you haven’t already.
2. Clone this repository:
   ```bash
   git clone [repository URL]
   ```
3. Navigate to the Terraform folder:
   ```bash
   cd terraform
   ```
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Terraform plan:
   ```bash
   terraform plan
   ```
6. Apply the Terraform configurations:
   ```bash
   terraform apply
   ```

Terraform will provision all the necessary resources to deploy the frontend and set up Auth0 integration.

## Installation

To run this project locally:

1. Clone the repository:
   ```bash
   git clone [repository URL]
   ```
2. Navigate to the React frontend directory:
   ```bash
   cd frontend
   ```
3. Install dependencies:
   ```bash
   yarn install
   ```
4. Set up your environment variables for the frontend to communicate with **Auth0** and use **CloudFront**.
5. Start the application:
   ```bash
   yarn run dev
   ```
6. Build the application for deployment:
   ```bash
   yarn run build
   ```
## Usage

Once deployed, the application can be accessed via the **CloudFront URL**. User login is handled by **Auth0** and redirects them to the app's protected pages post-login.

### Live URL:

- [HelloWorld Live App](https://d1992ly3dsmie5.cloudfront.net/)
