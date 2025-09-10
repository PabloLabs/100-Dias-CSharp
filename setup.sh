#!/usr/bin/env bash
set -euo pipefail

# Configurações
REPO_NAME="100-Dias-CSharp"
CREATE_SOLUTION=true           # define para false se não quiser .sln geral
SOLUTION_NAME="CemDiasCSharp"  # nome da solução
DAYS_START=1
DAYS_END=100

# Conteúdo do README raiz (resumo da trilha)
readme_root() {
  cat <<'EOF'
# 100 Dias de C#

Este repositório contém uma trilha fixa de 100 exercícios de C# que progride do zero ao avançado, com explicações didáticas e um desafio extra por dia.  
Para estudar, abra a pasta do dia (Dia001…Dia100) e edite o Program.cs seguindo o enunciado publicado quando solicitar “Dia X”.

## Estrutura
- Dia001 … Dia100 — projetos de console independentes
- Cada dia possui:
  - Program.cs inicial
  - README.md com espaço para enunciado, objetivos, passos e desafio

## Como rodar
- Entre na pasta do dia e execute:
  - dotnet run

Bons estudos!
EOF
}

# Template Program.cs inicial
program_cs() {
  local day="$1"
  cat <<EOF
using System;

namespace ${SOLUTION_NAME}.Dia${day}
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.OutputEncoding = System.Text.Encoding.UTF8;
            Console.WriteLine("Dia ${day} — Bem-vindo! Substitua este conteúdo pelo exercício do Dia ${day} quando solicitado.");
        }
    }
}
EOF
}

# Template README do dia
readme_day() {
  local day_label="$1"
  cat <<EOF
# ${day_label}

- Enunciado: (será preenchido quando for solicitado o exercício do dia)
- Objetivos:
  - (listar objetivos)
- Passo a passo:
  - (instruções passo a passo)
- Desafio extra:
  - (desafio para fixação)

Como executar:
- dotnet run
EOF
}

# Criar solução opcional
create_solution() {
  if [ "$CREATE_SOLUTION" = true ]; then
    dotnet new sln -n "${SOLUTION_NAME}" || true
  fi
}

# Normaliza número do dia com zero-padding
pad() {
  printf "%03d" "$1"
}

main() {
  # Gera README raiz
  readme_root > README.md

  # Cria solução, se habilitado
  create_solution

  # Loop dos dias
  for d in $(seq ${DAYS_START} ${DAYS_END}); do
    dpad=$(pad "$d")
    day_folder="Dia${dpad}"
    proj_name="Dia${dpad}"

    echo "==> Criando ${day_folder}"
    mkdir -p "${day_folder}"
    pushd "${day_folder}" >/dev/null

    # Projeto console
    dotnet new console -n "${proj_name}" --force >/dev/null

    # Ajusta Program.cs com template
    # Substitui o Program.cs gerado pelo nosso template
    ns_day="${dpad}"
    program_cs "${dpad}" > "${proj_name}/Program.cs"

    # README do dia
    readme_day "Dia ${dpad}" > README.md

    popd >/dev/null

    # Adiciona projeto à solução
    if [ "$CREATE_SOLUTION" = true ]; then
      dotnet sln "${SOLUTION_NAME}.sln" add "${day_folder}/${proj_name}/${proj_name}.csproj" >/dev/null
    fi
  done

  # Gera índice com links no README raiz
  {
    echo
    echo "## Índice"
    for d in $(seq ${DAYS_START} ${DAYS_END}); do
      dpad=$(pad "$d")
      echo "- [Dia ${dpad}](Dia${dpad}/README.md)"
    done
  } >> README.md

  echo "Estrutura criada com sucesso."
  echo "Lembrete: faça commit e push:"
  echo "  git add . && git commit -m \"chore: estrutura Dia001..Dia100\" && git push"
}

main "$@"

