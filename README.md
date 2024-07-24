# Configuração de Infraestrutura na Azure usando Terraform

Nesse repositório tem arquivos  **terraforms**  para configurar uma infraestrutura básica na Azure, que  inclui um conjunto de recursos, redes, uma máquina virtual Linux  e um script que  instala o docker e docker-compose e faz  upload  de  três  arquivos com a máquina virtual.  Sendo eles: o  docker-compose.yml, Dockerfile e  index.html .


## Pré-requisitos

-   Conta na [Azure](https://azure.microsoft.com/en-us/free/search/?ef_id=_k_CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE_k_&OCID=AIDcmmzmnb0182_SEM__k_CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE_k_&gad_source=1&gclid=CjwKCAjwzIK1BhAuEiwAHQmU3lENXx33EijviMW_isbuMq7kpPgJAgHituM5vTSp54Q2Ej408UYNPhoCXIUQAvD_BwE) com as credenciais configuradas localmente.
-   Terraform instalado localmente. [Instalação do Terraform](https://developer.hashicorp.com/terraform/install).


##  Passo a Passo

-  Clone o repositório

	`git clone https://github.com/Joao-Silva01/Script_Terraform.git`

	`cd  Script_Terraform`
	
- Inicia o terraform no repositório

	`terraform init`

- Visualiza para ver se tem algum erro de planejamento

	`terraform plan`

- Aplique o script terraform

  `terraform apply`

- Confirme o Apply

   Digite `yes` para confirmar as mudanças.

- Endereço público da máquina virtual
  Após a aplicação ser concluída, você poderá ter o acesso a máquina virtual utilizando o endereço IP público fornecido na saída.
  
##  Destruição da aplicação
Caso queira evitar cobranças na sua conta Azure, remova todos os recursos provisionados quando não tiver mais uso:

`terraform destroy`
