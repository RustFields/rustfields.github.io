# DevOps Techniques

`DevOps` engineering is a software development methodology that aims at communication and collaboration among developers and information technologies workers. This set of techniques respond to interdependencies between software development and relative IT operations, allowing a faster and more efficient organization of software products and services.

The following paragraphs describe which DevOps techniques have been used in the making of the system, focusing on the advantages that each procedure has brought.

## DVCS Strategy

### Workflow
A GitHub organization named [RustFields](https://github.com/RustFields) was associated to the entire project. By doing so, every aspect of the project could be handled in a specific repository inside the organization.

The team agreed on working with `Git Flow` workflow inside the implementation repositories, adapting it following the specific needs. Before merging code on the `main/master` branch, feature branches need to be approved by other team members using the `Pull Request` GitHub's service. In the "lightweight" repositories, such as the [GitHub Page](https://github.com/RustFields/rustfields.github.io) one, the team chose not to use this complex mechanism.

TODO feature branch name convention

### Commits

The team adopted the [conventional-commit convention](https://www.conventionalcommits.org/en/v1.0.0/). This strategy provides an easy set of rules for creating an explicit commit history and allows to automatically define the number of versions released.

The team agreed on an extension of the standard convention, using the following set of commit types:

* **feat!**: identifies a breaking change feature, increasing the major version number.
* **feat**: identifies a feature, increasing the minor version number.
* **fix**: identifies a patch change, increasing the patch version number.
* **chore**: identifies a minor change that doesn't affect the overall system's behaviour.
* **docs**: identifies an update to the documentation.
* **ci**: identifies changes in the repository's workflow definition.
* **deps**: identifies the update of a library dependency.

### Versioning

Following the conventional commit standard, the version number is defined in the format `vX.Y.Z` where:

* `X`: indicates the **major version** and is incremented when a breaking change occurs.
* `Y`: indicates a **minor version** and is incremented every time a new feature is introduced in the system.
* `Z`: indicates a **patch version** where typically errors are fixed and those changes do not modify the system APIs.

[comment]: <> (### Commit Lint Check)

## Continuous Integration
### GitHub Actions
### Code Quality Control
### Tests

[comment]: <> (### Automatic Dependency Update)

## Continuous Delivery

### Semantic Versioning and Releasing

[comment]: <> (### Containerization)

## Licenses