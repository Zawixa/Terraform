# Terraform

Ce projet vise à déployer une infrastructure cloud sur Azure à l'aide de Terraform. Il inclut la création d'un groupe de ressources, d'un compte de stockage, et d'une machine virtuelle Linux Ubuntu 22 LTS.

## Prérequis

- Un compte Azure
- [Azure CLI](https://learn.microsoft.com/fr-fr/cli/azure/install-azure-cli) installé
- [Terraform]

## Installation

### 1. Configuration de l'Azure CLI

Après l'installation de l'Azure CLI, connectez-vous à votre compte Azure :

az login

### 2. Création d'un Service Principal

Utilisez la commande suivante pour créer un Service Principal, qui sera utilisé par Terraform pour gérer les ressources Azure :

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<VotreSubscriptionId>"


Notez les valeurs `appId`, `password`, et `tenant` retournées par cette commande, car elles seront utilisées comme variables d'environnement.

### 3. Configuration des variables d'environnement

Configurez les variables d'environnement nécessaires pour Terraform :

export ARM_SUBSCRIPTION_ID=<VotreSubscriptionId>
export ARM_CLIENT_ID=<appId>
export ARM_CLIENT_SECRET=<password>
export ARM_TENANT_ID=<tenant>

### 4.Installation de terraform sur votre machine 
documentation à suivre : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

### Déploiement de l'infrastructure
Créer un répertoire pour votre terraform 
Réupérer les fichier versions.tf, main.tf, sa.tf, vm.tf 
Pour initialiser Terraform et déployer l'infrastructure définie dans vos fichiers de configuration `.tf`, exécutez :
1. terraform init
2. terraform validate
3. terraform plan 
4. terraform apply
5. terraform state list (pour voir les fichiers créés) 


### Destruction de l'infrastructure

Pour détruire l'infrastructure déployée par Terraform, utilisez :

terraform destroy
