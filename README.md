# Configuração de Infraestrutura na Azure

Nesse repositório tem um arquivo **terraform** que configura uma infraestrutura básica na Azure, que  inclui um conjunto de recursos, redes, uma máquina virtual Linux  e um script que  instala o docker e docker-compose e faz  upload  de  três  arquivos junto com a máquina virtual.  Sendo eles: o  docker-compose.yml, Dockerfile e  index.html .


## Requisitos

-   Uma conta na [Azure](https://azure.microsoft.com/en-us/free/search/?ef_id=_k_CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE_k_&OCID=AIDcmmzmnb0182_SEM__k_CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE_k_&gad_source=1&gclid=CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE) com as credenciais configuradas localmente.
-   Ter o terraform instalado localmente. [Terraform install](https://developer.hashicorp.com/terraform/install).


##  Passo a Passo

-  Clone o repositório

	`git clone https://github.com/Joao-Silva01/Script_Terraform.git`

	`cd  Script_Terraform`
	
- Inicia o terraform no repositório

	`terraform init`

- Visualiza para ver se tem algum erro de planejamento

	`terraform plan`

- Aplicação do script terraform

  `terraform apply`

- Confirme o Apply

  Verifique se as mudanças estão de acordo, caso sim digite `yes` para confirmar as mudanças.

- Endereço público da máquina virtual
  
  Após o apply ser concluído, você poderá ter o acesso a máquina virtual usando o endereço IP público que será fornecido no final da saída .
  
##  Destruição da aplicação
Caso queira evitar cobranças na sua conta da Azure, remova todos os recursos provisionados pelo script quando não tiver mais uso, utilizando o comando:

`terraform destroy`
