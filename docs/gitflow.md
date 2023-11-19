---
comments: true
---
# Git Flow

``` mermaid
gitGraph
    commit tag: "v0.4.0"
    branch feature
    checkout main
    commit
    branch bugfix
    commit
    checkout feature
    commit id: "Dark Theme"
    checkout main
    merge feature
    commit tag: "v0.4.1"
    commit
    checkout bugfix
    commit id: "Fixed Null Ref"
    checkout main
    merge bugfix tag: "v0.4.2"
    commit
```

The main point to understand about Gitflow is that a snapshot or branch is created, feature development is done, and when the changes are merged into main, the branch is automatically closed.

Real gitops nerds will argue about the structure of repositories, but we need to understand what are the things that are important to customers. We dont need to be experts in Java and c++ in order to understand how to map products into an architecture maintained by developers.
