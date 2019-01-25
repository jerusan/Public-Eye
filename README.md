# InThePublicEye

## Overview
In The Public Eye is a Senior Design project at the University of Minnesota.

## Rules
It is advised that before you begin contributing anything to this repository, you review a couple of things on the Wiki first. The following is a list of things you should most certainly review so nothing gets messed up.
1. If you do not know how version control works or don't know how to use github...it's time to learn. Checkout the [Learning Git](https://github.umn.edu/willow/Public-Eye/wiki/References#learning-git) section on the Wiki for a bunch of awesome links to get some knowledge bombs. Real talk, having this knowledge in your arsenal is important and extremely useful in the real world.
2. Read the rules on the Wiki about [Contributing](https://github.umn.edu/willow/Public-Eye/wiki/Contributing). If you don't like them, discuss it with your group and change them. 
3. Be aware of the [Branches & Workflow](https://github.umn.edu/willow/Public-Eye/tree/dev#branches--workflow) being adopted for this project. If you come up with a better workflow, discuss it with your group, change it, and update the documentation accordingly. We chose this workflow because it made the most sense for our group, but there are plenty of different approaches we could have taken with this.

## Branches & Workflow
This is a definition of the workflow our team is using for development. This repository contains 2 different branches: _master_ and _dev_. The _master_ branch represents the most stable version of the project and we will only be deploying to production from this branch. The _dev_ branch contains changes that are in progress and may not necessarily be ready for production.

From the _dev_ branch, one can create topic branches to work on individual features and fixes. Once the feature/fix is ready to go, it can be merged into _dev_, at which point we can test how it interacts with other topic branches that have been merged in by team members. So, once _dev_ is in a stable state, it should be merged into _master_. It should always be safe to deploy to production code from the _master_ branch.
