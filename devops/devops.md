---
layout: default
title: DevOps Techniques
nav_order: 7
permalink: /devops
---
## Table of contents
{: .no_toc .text-delta }
1. TOC
   {:toc}
---

# DevOps Techniques

`DevOps` engineering is a software development methodology that aims at communication and collaboration among developers and information technologies workers. This set of techniques responds to interdependencies between software development and relative IT operations, allowing a faster and more efficient organization of software products and services.

The following paragraphs describe which DevOps techniques have been used in the making of the system, focusing on the advantages that each procedure has brought.

## DVCS Strategy

### Workflow
A GitHub organization named [RustFields](https://github.com/RustFields) was associated with the entire project. By doing so, every aspect of the project could be handled in a specific repository inside the organization.

The team agreed on working with `Git Flow` workflow inside the implementation repositories, adapting it following the specific needs. Before merging code on the `main/master` branch, feature branches need to be approved by other team members using the `Pull Request` GitHub's service. In the "lightweight" repositories, such as [rustfields.github.io](https://github.com/RustFields/rustfields.github.io), the team chose not to use this complex mechanism.

All the feature branches will follow a common structure based on the following template:

`feature/{feature-name}`

### Commits

The team adopted the [conventional-commit convention](https://www.conventionalcommits.org/en/v1.0.0/). This strategy provides an easy set of rules for creating an explicit commit history and allows to automatically define the number of versions released.

The team agreed on an extension of the standard convention, using the following set of commit types:

- **MAJOR release**
  - Any commit type and scope terminating with `!` causes a `BREAKING CHANGE`
- **MINOR release**
  - Commit type `chore` with scope `api-deps` (Dependency updates)
  - Commit type `feat` (Features) with any scope
- **PATCH release**
  - Commit type `chore` with scope `core-deps` (Dependency updates)
  - Commit type `fix` (Bug Fixes) with any scope
  - Commit type `docs` (Documentation) with any scope
  - Commit type `perf` (Performance improvements) with any scope
  - Commit type `revert` (Revert previous changes) with any scope
- **No release**
  - Commit type `test` (Tests)
  - Commit type `ci` (Build and continuous integration)
  - Commit type `build` (Build and continuous integration)
  - Commit type `chore` with scope `deps` (Dependency updates)
  - Commit type `chore` (General maintenance) with scopes different than the ones mentioned above
  - Commit type `style` (Style improvements) with any scope
  - Commit type `refactor` (Refactoring) with any scope

To ensure that the commits made are conformant to the required pattern, the team used `Git Hooks`.

### Versioning

Following the conventional commit standard, the version number is defined in the format `X.Y.Z` where:

* `X`: indicates a **major version** and is incremented when a breaking change occurs.
* `Y`: indicates a **minor version** and is incremented every time a new feature is introduced in the system.
* `Z`: indicates a **patch version** where typically errors are fixed and those changes do not modify the system APIs.

[comment]: <> (### Commit Lint Check)

## Continuous Integration

### GitHub Actions

The team decided to use the `GitHub Actions` service. The team used the following set of GitHub Actions for the project:

* TODO
* TODO

Each repository has two active workflows, one for the Continuous Integration (CI) and another one for the Continuous Delivery (CD).

### Code Quality Control

### Tests


### Automatic Dependency Update

The team agreed on using `renovate` for automatic dependencies updates.

## Continuous Delivery

### Semantic Versioning and Releasing

Thanks to the use of [Semantic Release](https://github.com/semantic-release/semantic-release) it was possible to automate all the versioning and releasing work. In particular, the action automatically calculates if a new version release is needed based on the committed commits in the `main/master` branch. If there is a commit that triggers a new version release (major, minor or patch) then the action creates the new tag, adding the appropriate version number to the one previously released, and then will create the GitHub Release with the reference of the last commit pushed on `main/master` branch.

## Licenses

Every repository in the organization is endowed with the Apache License 2.0.