# VSCode devcontainers with common tools for rapid in-cluster Go development

Disclaimer: This is a work in progress. I'm still working on getting the devcontainers and tools to work as expected. I'll update this README as I make progress.

## The purpose of this repository

In working with Go, I've found that there are a number of tools that I use regularly. This repository contains a number of devcontainers that I've created to make it easier to get started with Go development.

## Differences between this and the standard Go devcontainers

Compared to the standard Go devcontainer knows from Github Codespaces and similar tools, this devcontainer is meant to be more opinionated and include a number of tools that I use regularly.

Moreover, I'm using it as a way for in-cluster development to make it easier to develop and test Go applications inside Kubernetes.

For example, if you want to test your application inside your development cluster, you could replace the image in your deployment files with this one. Then, connect to your container using the Kubernetes and VSCode Devcontainers extension, and execute your services live.

This is especially useful to circumvent the need to rebuild and redeploy your service every time you make a change, and you get to test your service in the same environment that it will run in, without any tunnels, VPNs, external tools, cluster agents or NAT traversal magic! How great is that?

## How to use it?

TODO: Add instructions on how to use this devcontainer.
