---
comments: true
---
# GitOps

![GitOps](img/gitops.png)

GitOps is the priciple of keeping CI separate from CD, in other words the development pipelines produce artifacts using their tools and those artifacts are then consumed by the delivery truck to get those products into product. The operations of delivery can use the same tools.

There are many of these trendy combinations of two things, but GitOps is important to understand becuase applying an SDLC to infrastructure is done with the ecosystem of tools that are used to create responses to actions. We are going to use GitHub Actions to demosntrate the concepts, but long before GitHub came along tools like Jenkins or ArgoCD were used to receive webhooks to trigger actions.
