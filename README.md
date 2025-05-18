Here is a `README.md` file that describes how to access the Spring Boot application exposed via the provided Kubernetes Ingress:

```markdown
# Kubernetes Demo Application - Access Guide

This guide provides instructions to access the deployed Spring Boot application using the configured Kubernetes Ingress.

## 🌐 Application Access

The application is exposed via an **NGINX Ingress Controller** in an AWS EKS cluster. You can access the application using the following Load Balancer DNS

> **Note:** The Ingress is configured without SSL (HTTP only). No path-based routing is implemented beyond the root path (`/`).

## ⚙️ Ingress Configuration

The application is made available externally using the following Ingress configuration:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: k8s-demo-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  ingressClassName: nginx
  rules:
    - host: a3d25593421fd4e439ee2c4f73a0021e-1430597695.us-east-1.elb.amazonaws.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: k8s-demo
                port:
                  number: 8080
````

## 🧪 Testing the Endpoint

You can test the application endpoint using `curl` or by opening the link in a web browser:

### Curl Example:

```bash
curl http://a3d25593421fd4e439ee2c4f73a0021e-1430597695.us-east-1.elb.amazonaws.com/api/hello
```

### Browser Access:

Simply open your browser and navigate to:

```
http://a3d25593421fd4e439ee2c4f73a0021e-1430597695.us-east-1.elb.amazonaws.com/api/hello
```

## ✅ Prerequisites for Successful Access

Ensure the following are configured:

* The NGINX Ingress Controller is deployed in the cluster.
* The `k8s-demo` service is running and exposing port `8080`.

## ✅ Deployment with current version

<img width="650" alt="image" src="https://github.com/user-attachments/assets/3071035f-f893-4408-a7b6-07424c797874" />

## ✅ Deployment with new version

<img width="647" alt="image" src="https://github.com/user-attachments/assets/013ab3fd-2fe8-4a58-856e-c3310fb1c678" />

