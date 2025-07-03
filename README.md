# EKS Express

Este é o repositório utilizado dentro do curso para gerenciar toda infraestrutura do projeto `eks-express`. Este projeto é composto por diversas stacks na pasta visando provisionar toda infraestrutura necessária para subir um Cluster EKS na AWS Production grade.

Toda essa stack é desenvolvida do absoluto zero, aula por aula. Recomendo que você assista as aulas em paralelo ao estudo do código deste repositório na sua conta AWS para melhor entendimento do que está provisionando.

---

## 🛠️ Configuração e Execução

### 1. Configuração da Role na AWS

Antes de realizar o deployment das stacks do Terraform, crie uma Role na sua conta AWS:

**Atenção:** Substitua as variáveis, `<YOUR_ACCOUNT>` e `<YOUR_USER>`.

```bash
aws iam create-role \
    --role-name DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a \
    --assume-role-policy-document '{
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::<YOUR_ACCOUNT>:user/<YOUR_USER>"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "f2ed091d-8d7d-46cb-be56-fb349d502cfb"
                }
            }
        }]
    }'
```

📌 **Observação:** Para dúvidas, consulte Aula 05-AWS Role e Terraform Authentication do Módulo 2.

---

### 2. Anexar Permissões Administrativas

Anexe permissões administrativas à role criada:

```bash
aws iam attach-role-policy \
    --role-name DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

---

### 3. Substituição da String `arn:aws:iam::<YOUR_ACCOUNT>:role/DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a` nos Arquivos Terraform

#### 🐧 **(WSL/Linux)**

```bash
find . -type f -name "*.tf" -exec sed -i \
    's|arn:aws:iam::<YOUR_ACCOUNT>:role/DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a|arn:aws:iam::<YOUR_ACCOUNT>:role/DevOpsNaNuvemRole|g' {} +
```

#### 🍎 **(MacOS)**

```bash
find . -type f -name "*.tf" -exec sed -i '' \
    's|arn:aws:iam::<YOUR_ACCOUNT>:role/DevOpsNaNuvemRole-9db671b2-c6ce-460c-9eb0-f27e903d0f9a|arn:aws:iam::<YOUR_ACCOUNT>:role/DevOpsNaNuvemRole|g' {} +
```

**Atenção:** Substitua `<YOUR_ACCOUNT>` pela sua conta AWS.

---

### 4. Deploy da Stack `backend`

A stack `backend` cria o bucket S3 e a DynamoDB para o Terraform state locking e remote backend:

```bash
cd ./00-backend && terraform init && terraform apply -auto-approve
```
---
📌 **Observação:** O comando considera que você está na pasta root da aplicação.

### 5. Deploy da Stack `networking`

Crie a base de redes para as próximas stacks:

```bash
cd ./01-networking && terraform init && terraform apply -auto-approve
```

---

### 6. Deploy da Stack `eks-cluster`

Crie um Cluster EKS, juntamente com alguns addons já instalados.

```bash
cd ./02-eks-cluster && terraform init && terraform apply -auto-approve
```
---
📌 **Observação:** Se necessário ajuste a quantidade de nós worker nodes desejados no arquivo variables.tf.

### 7. Deploy da Stack `karpenter-auto-scaling`

Torne o Cluster EKS dinâmico, adicionando e removendo nós dinamicamente utilizando Karpenter

```bash
cd ./03-karpenter-auto-scaling && terraform init && terraform apply -auto-approve
```

---

### 8. Deploy da Stack `site`

Habilite o Web Application Firewall para filtrar requisições do Application Load Balancer:

```bash
cd ./04-security && terraform init && terraform apply -auto-approve
```
---
📌 **Observação:** Lembre-se que a conexão do WAF ACL com o ALB é feito via annotation no ingress.

### 9. Deploy da Stack `monitoring`

Configure o Amazon Prometheus e Grafana, para monitorar o Cluster EKS:

```bash
cd ./05-monitoring && terraform init && terraform apply -auto-approve
```

## 🗑️ Deletar Infraestrutura Criada

Para destruir os recursos provisionados, siga esta ordem:

```bash
cd ./05-monitoring && terraform destroy -auto-approve
cd ./04-security && terraform destroy -target=helm_release.external_dns
cd ./04-security && terraform destroy -target=helm_release.load_balancer_controller
cd ./04-security && terraform destroy -auto-approve
cd ./03-karpenter-auto-scaling && terraform destroy -auto-approve
cd ./02-eks-cluster && terraform destroy -auto-approve
cd ./01-networking && terraform destroy -auto-approve
```

**Atenção:** Mantenha a ordem ao destruir as stacks para evitar dependências quebradas.
