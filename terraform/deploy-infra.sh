#!/usr/bin/env bash

# Script para facilitar a execução local do Terraform
# Uso: ./deploy-infra.sh [plan|apply|destroy] [true|false (use_aws_academy)]

ACTION=${1:-"plan"}
USE_ACADEMY=${2:-"true"}

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}===================================================${NC}"
echo -e "${YELLOW} Executando Terraform para o Tech Challenge ${NC}"
echo -e "${YELLOW} Ação: $ACTION | AWS Academy (LabRole): $USE_ACADEMY ${NC}"
echo -e "${YELLOW}===================================================${NC}"

# Verificar se o terraform está instalado
if ! command -v terraform &> /dev/null; then
    echo -e "${RED}Erro: Terraform não encontrado no path. Por favor instale-o.${NC}"
    exit 1
fi

# Inicializar
echo -e "\n${GREEN}[1/3] Inicializando Terraform (init)...${NC}"
terraform init

# Validar
echo -e "\n${GREEN}[2/3] Validando sintaxe e arquivos...${NC}"
terraform validate
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro de validação detectado! Corrija os arquivos antes de prosseguir.${NC}"
    exit 1
fi

# Executar Ação
echo -e "\n${GREEN}[3/3] Executando ação: $ACTION...${NC}"
if [ "$ACTION" == "plan" ]; then
    terraform plan -var="use_aws_academy=$USE_ACADEMY"
elif [ "$ACTION" == "apply" ]; then
    terraform apply -auto-approve -var="use_aws_academy=$USE_ACADEMY"
elif [ "$ACTION" == "destroy" ]; then
    terraform destroy -auto-approve -var="use_aws_academy=$USE_ACADEMY"
else
    echo -e "${RED}Erro: Ação inválida '$ACTION'. Use 'plan', 'apply' ou 'destroy'.${NC}"
    exit 1
fi
