Here is a professional and comprehensive `deployment.md` document that corresponds to `main.yaml` GitHub Actions workflow file:

```markdown
# CI/CD Deployment Process for `mindmap-demo`

This document outlines the continuous integration and deployment (CI/CD) pipeline for the `mindmap-demo` application using GitHub Actions, Docker, Amazon ECR, and AWS EKS.

---

## 🚀 Pipeline Triggers

The GitHub Actions workflow is triggered by the following events:

- Push to the `main` branch.
- Pull request targeting the `main` branch.
- Manual trigger using `workflow_dispatch`.

---

## 🧱 CI/CD Workflow Stages

### 1. **Checkout the Code**
- Uses: `actions/checkout@v3`
- Clones the repository code into the runner environment.

### 2. **Set Up Java Environment**
- Uses: `actions/setup-java@v3`
- Java 17 (Temurin distribution) is configured.

### 3. **Run Unit Tests**
- Executes: `mvn clean test`
- Runs all unit tests to ensure code correctness.

### 4. **Run Integration Tests**
- Executes: `mvn failsafe:integration-test failsafe:verify`
- Runs integration tests post-build.

### 5. **Install `kubectl`**
- Uses: `azure/setup-kubectl@v2.0`
- Installs `kubectl` CLI to interact with Kubernetes.

### 6. **Configure AWS Credentials**
- Uses: `aws-actions/configure-aws-credentials@v1`
- Injects AWS credentials using GitHub Secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- Region: `us-east-1`

### 7. **Login to Amazon ECR**
- Uses: `aws-actions/amazon-ecr-login@v1`
- Authenticates Docker to Amazon Elastic Container Registry (ECR).

### 8. **Build & Push Docker Image**
- Tags the image with the GitHub run number.
- Builds and pushes the image to ECR:
```

docker build -t \$REGISTRY/mindmap-demo:\$IMAGE\_TAG .
docker push \$REGISTRY/mindmap-demo:\$IMAGE\_TAG

```

### 9. **Scan Docker Image in ECR**
- Initiates vulnerability scan using:
```

aws ecr start-image-scan

```

### 10. **Wait for Image Scan Completion**
- Polls scan status until it completes.

### 11. **Validate Scan Findings**
- Fails pipeline if vulnerabilities are detected:
```

if \[ "\$VULNERABILITIES" -gt 0 ]; then exit 1; fi

```

### 12. **Update Kubeconfig**
- Updates local kubeconfig for the `demo` EKS cluster:
```

aws eks update-kubeconfig --name demo

```

### 13. **Update Deployment Manifest**
- Replaces `${BUILD_NUMBER}` in `deployment.yaml` with the current run number:
```

sed -i "s|\${BUILD\_NUMBER}|\${{ github.run\_number }}|g" ./k8s/deployment.yaml

```

### 14. **Apply Kubernetes Manifests**
- Applies all manifests in the `./k8s` directory:
```

kubectl apply -f ./k8s/

```

### 15. **Monitor Rollout Status**
- Waits for deployment rollout to complete:
```

kubectl rollout status deployment/k8s-demo -n default

```

### 16. **Rollback on Failure**
- Automatically triggers a rollback if the deployment fails:
```

kubectl rollout undo deployment/k8s-demo -n default

```

---

## 📁 Kubernetes Manifests Directory Structure (`./k8s`)

- `deployment.yaml`: Kubernetes Deployment (image updated dynamically).
- `service.yaml`: Service to expose the application.
- `configmap.yaml`: Application-specific configuration.
- `ingress.yaml`: Ingress resource for external access.
- `hpa.yaml`: Horizontal Pod Autoscaler (optional).

---

## 🛡️ Security Practices

- AWS credentials stored securely in GitHub Secrets.
- Docker images scanned for vulnerabilities before deployment.
- Deployment is automatically rolled back if issues are detected.

---

## ✅ Final Outcome

After a successful pipeline execution, the latest tested and verified version of the `mindmap-demo` application is:
- Built using Maven
- Packaged and pushed to Amazon ECR
- Deployed to AWS EKS
- Verified for security and health
```
