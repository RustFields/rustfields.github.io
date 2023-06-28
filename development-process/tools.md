---
title: Tools
parent: Development Process 
has_children: false
nav_order: 1
---

# Tools

For the realization of the project, different tools were used to support the development process. These tools aim to facilitate developers throughout the project realization.

## GitHub

[GitHub](https://github.com/) is a hosting service for software development and version control management based on Git. It provides Git's distributed version control along with access control, bug tracking, software feature requests, task management, continuous integration, and a wiki for every project.

For our project, we used GitHub as a hosting service for the source code, GitHub Actions to promote the continuous integration process, GitHub Projects for defining tasks and GitHub Pages for documentation and explanation of the system implemented.

## Renovate
[Renovate](https://docs.renovatebot.com/) is a GitHub application that automates dependency updates for software projects. It scans a project's dependencies and creates pull requests to update them to their latest versions. Renovate supports a wide range of programming languages and package managers, making it a versatile tool for maintaining software projects. It also has a range of configuration options that allow users to customize the update process to fit their specific needs.

## Mergify
[Mergify](https://mergify.com/) Mergify is a powerful automation tool designed specifically for GitHub repositories. It streamlines and automates various aspects of the software development workflow, particularly when collaborating with multiple contributors. Mergify provides a wide range of features and functionalities that enhance productivity and ensure efficient management of pull requests. It allows users to create custom rules and conditions for automatically merging, closing, or labeling pull requests based on specific criteria.

## Semantic Release
[Semantic Release](https://semantic-release.gitbook.io/semantic-release/) is a service that automates the package release process for software projects. It uses semantic versioning to determine the next version number and generates release notes based on commit messages. The app also updates the changelog, creates a Git tag, and publishes the new version to the package registry. This allows developers to streamline their release workflow and ensure that their software versions are consistent and correctly versioned.

## Gradle
[Gradle](https://gradle.org/) is an open-source, JVM-based build automation tool that enables the automation of Java project building. It also makes it easy to set up different libraries that can be used within the project without the need to include .jar files but instead specifying dependencies directly from a remote repository. Gradle also allows the management of a project consisting of multiple modules and the different dependencies that may exist between them.

## SBT
[SBT](https://www.scala-sbt.org/) is an open-source build tool created explicitly for Scala and Java projects. It aims to streamline the procedure of constructing, compiling, testing, and packaging applications, libraries, and frameworks.

## Cargo
[Cargo](https://doc.rust-lang.org/cargo/) is the Rust package manager. Cargo downloads your Rust package’s dependencies, compiles your packages, makes distributable packages, and uploads them to crates.io, the Rust community’s package registry.

## ScalaTest
[ScalaTest](https://www.scalatest.org/) is a popular testing framework for the Scala programming language. It provides a broad set of features for different styles of testing, including unit, functional, and acceptance testing. ScalaTest supports a variety of testing approaches, such as Behavior-Driven Development (BDD) and Test-Driven Development (TDD), and provides a rich set of matchers to make assertions easier to read and write. The framework can be used with popular build tools like SBT and Maven, and supports integration with other Scala frameworks like Scala Native.
