#!/usr/bin/env bash
set -euo pipefail

# tools/bootstrap.sh
# Preenche READMEs Dia001..Dia100 e instala hook para mensagens de commit automáticas.
# Execute a partir da raiz do repositório.

ROOT_README="README.md"

# Mapa de dias: "001|Titulo curto|Enunciado curto"
readarray -t DAYS_DEF <<'EOF'
001|Dia 001 — Olá, Mundo|Escreva na tela "Olá, Mundo!" e execute um console app .NET.
002|Dia 002 — Console e comentários|Mostre mensagens com Write/WriteLine e use comentários de linha e bloco.
003|Dia 003 — Variáveis básicas|Declare int, double, string, bool e imprima seus valores.
004|Dia 004 — Entrada e conversão|Leia dois números com ReadLine e some, usando int.Parse/TryParse.
005|Dia 005 — Operadores aritméticos|Pratique +, -, *, /, % resolvendo média e troco simples.
006|Dia 006 — Comparação e lógicos|Use ==, !=, >, <, >=, <=, &&, ||, ! em testes práticos.
007|Dia 007 — if/else|Implemente regras de desconto e verificação de maioridade.
008|Dia 008 — switch|Crie um menu de opções numéricas com switch.
009|Dia 009 — while|Conte números e valide entrada repetindo até ficar correta.
010|Dia 010 — for|Gere tabuadas e somatórios com for.
011|Dia 011 — do/while|Pergunte “Deseja continuar? (S/N)” até confirmar.
012|Dia 012 — Array 1D|Preencha e calcule média de um array de números.
013|Dia 013 — Matriz 2D|Some linhas/colunas e imprima uma tabela.
014|Dia 014 — List<T>|Adicionar, remover, buscar e ordenar números em lista.
015|Dia 015 — Métodos|Crie funções com parâmetros e retorno para reutilização.
016|Dia 016 — Sobrecarga|Mesmo nome, assinaturas diferentes resolvendo cálculos.
017|Dia 017 — Valor vs referência|Mostre diferenças usando int e List<T>.
018|Dia 018 — Strings|Concatene, interpole, Substring, Replace, Split, Trim.
019|Dia 019 — Datas e tempos|Calcule idade e prazos com DateTime/TimeSpan.
020|Dia 020 — TryParse e erros|Evite exceções ao converter entradas.
021|Dia 021 — Exceções|try/catch/finally com mensagens amigáveis.
022|Dia 022 — Enum|Estados de pedido e uso em switch.
023|Dia 023 — Tuplas|Retorne múltiplos valores de um método.
024|Dia 024 — Records|Crie um record DTO imutável (C# 9+).
025|Dia 025 — OOP: classe|Classe Pessoa com propriedades e método Descrever.
026|Dia 026 — Construtores|Inicialize objetos com validação.
027|Dia 027 — Encapsulamento|get/set com validação em propriedades.
028|Dia 028 — Estático vs instância|Quando usar métodos estáticos vs de instância.
029|Dia 029 — ToString/Equals|Personalize representação e igualdade.
030|Dia 030 — Coleções de objetos|List<Pessoa> com buscas e filtros.
031|Dia 031 — Herança|Animal, Cachorro, Gato herdando comportamento.
032|Dia 032 — Polimorfismo|virtual/override com comportamentos específicos.
033|Dia 033 — Interfaces|INotificavel implementado por Email e SMS.
034|Dia 034 — Abstração|Forma abstrata com Area(); Quadrado/Círculo.
035|Dia 035 — Composição|Pedido com Itens e cálculo de total.
036|Dia 036 — Dictionary|Agenda telefônica com chave/valor.
037|Dia 037 — HashSet|Remova duplicatas e teste pertinência.
038|Dia 038 — Queue/Stack|Simule fila e pilha de tarefas.
039|Dia 039 — Arquivos texto|Ler/escrever com File e Streams.
040|Dia 040 — Diretórios e Path|Criar, listar e combinar caminhos.
041|Dia 041 — JSON salvar|Serializar objetos com System.Text.Json.
042|Dia 042 — JSON carregar|Desserializar com tratamento de erros.
043|Dia 043 — Regex|Valide e-mail simples e CEP.
044|Dia 044 — LINQ básico|Where, Select, OrderBy em listas.
045|Dia 045 — LINQ avançado|GroupBy, Join, Any/All, First/Single.
046|Dia 046 — Métodos de extensão|Crie extensões úteis para string.
047|Dia 047 — Nullability|Tipos anuláveis, ??, ?. e boas práticas.
048|Dia 048 — Pattern matching|is, switch patterns e when.
049|Dia 049 — Params/nomeados|APIs mais amigáveis com params e nomes.
050|Dia 050 — Recursão|Fatorial e Fibonacci com cuidados.
051|Dia 051 — Complexidade|Noções de O(1), O(n), O(n log n).
052|Dia 052 — Testes unitários|Primeiro teste com xUnit.
053|Dia 053 — Mini TDD|Teste antes do código (calculadora).
054|Dia 054 — DI|Injeção de dependência em console.
055|Dia 055 — Logging|Microsoft.Extensions.Logging em console.
056|Dia 056 — Configurações|appsettings.json e options pattern.
057|Dia 057 — Async/await I|Task, await e atrasos simulados.
058|Dia 058 — Async/await II|WhenAll e cancelamento.
059|Dia 059 — HTTP GET/POST|HttpClient em API pública.
060|Dia 060 — Resiliência HTTP|Retry simples e timeout.
061|Dia 061 — Arquitetura camadas|Domínio, infra e UI em console.
062|Dia 062 — Regras de domínio|Validações e exceptions específicas.
063|Dia 063 — DTO ↔ Entidade|Mapeamento manual.
064|Dia 064 — LINQ em domínio|Consultas em listas de pedidos.
065|Dia 065 — Delegates/eventos|Notificar mudança de estoque.
066|Dia 066 — CSV|Parse e export de CSV simples.
067|Dia 067 — Cultura pt-BR|Formatar números, datas, moedas.
068|Dia 068 — Exceções custom|Crie e use exceptions próprias.
069|Dia 069 — Stopwatch|Medição de desempenho.
070|Dia 070 — Memória e GC|IDisposable e escopo.
071|Dia 071 — Span/Memory|Texto com menos alocação.
072|Dia 072 — Members com seta|Expression-bodied members.
073|Dia 073 — Operadores modernos|??=, range e indexadores.
074|Dia 074 — Reflection básico|Listar propriedades de objeto.
075|Dia 075 — Atributos|Criar atributo e ler via reflection.
076|Dia 076 — Mini-CLI|Interpretar comandos do usuário.
077|Dia 077 — Hash de senha|SHA256 com sal.
078|Dia 078 — Segredos|Variáveis de ambiente.
079|Dia 079 — NuGet|Instalar e usar pacote externo.
080|Dia 080 — Solução multi-proj|Organizar e referenciar projetos.
081|Dia 081 — EF Core I|DbContext em memória e entidades.
082|Dia 082 — EF Core II|Consultas e relacionamentos.
083|Dia 083 — EF Core III|Migrations e SQLite local.
084|Dia 084 — Minimal API I|API de tarefas (GET/POST).
085|Dia 085 — Minimal API II|Validação, filtros e status.
086|Dia 086 — Controllers|CRUD com ControllerBase.
087|Dia 087 — Middleware|Pipeline e middleware custom.
088|Dia 088 — JWT básico|Proteger endpoints locais.
089|Dia 089 — Swagger|OpenAPI e contratos.
090|Dia 090 — Perfis execução|Publicação local de API/console.
091|Dia 091 — Visão clean arch|Camadas e casos de uso.
092|Dia 092 — Domain events|Disparar e tratar eventos.
093|Dia 093 — AutoMapper|Mapeamento automático básico.
094|Dia 094 — FluentValidation|Regras de entrada.
095|Dia 095 — Health checks|Checagens de aplicação.
096|Dia 096 — Observabilidade|Logs estruturados e correlação.
097|Dia 097 — Testes integração|WebApplicationFactory.
098|Dia 098 — Publicar single-file|API em arquivo único.
099|Dia 099 — Projeto final console|Mini-estoque com persistência.
100|Dia 100 — Projeto final API|Checklist de boas práticas.
EOF

# Helpers
pad() { printf "%03d" "$1"; }

write_day_readme() {
  local num="$1" title="$2" stmt="$3"
  local dir="Dia${num}"
  local readme="${dir}/README.md"
  cat > "${readme}" <<EOF
# ${title}

- Enunciado: ${stmt}
- Objetivos:
  - Compreender o porquê do código e praticar passo a passo.
  - Consolidar o tópico do dia com exemplo funcional.
- Passo a passo:
  - Leia o enunciado e planeje o que o programa precisa fazer.
  - Edite ${dir}/${dir}/Program.cs implementando a solução.
  - Rode com: dotnet run
- Desafio extra:
  - Extenda o exercício com uma pequena variação proposta por você.

Como executar:
- cd ${dir}/${dir}
- dotnet run
EOF
}

generate_root_readme() {
  cat > "${ROOT_README}" <<'EOF'
# 100 Dias de C#

Trilha fixa de 100 exercícios de C# do zero ao avançado, com explicações didáticas e desafio extra por dia. Abra a pasta do dia (Dia001…Dia100), implemente no Program.cs e rode com dotnet run.

## Índice
EOF
  for e in "${DAYS_DEF[@]}"; do
    IFS='|' read -r num title stmt <<<"$e"
    echo "- [${title}](Dia${num}/README.md) — ${stmt}" >> "${ROOT_README}"
  done
}

install_prepare_commit_hook() {
  mkdir -p .git/hooks
  cat > .git/hooks/prepare-commit-msg <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
MSG_FILE="$1"
COMMIT_SOURCE="${2:-}"

# Ignora merges
[[ "${COMMIT_SOURCE}" == "merge" ]] && exit 0

# Primeiro dia alterado
DAY_DIR=$(git diff --cached --name-only | grep -E '^Dia[0-9]{3}/' | cut -d'/' -f1 | sort -u | head -n1 || true)
[[ -z "${DAY_DIR:-}" ]] && exit 0

DAY_README="${DAY_DIR}/README.md"
TITLE="Dia ${DAY_DIR#Dia}"
SUB=""

if [[ -f "${DAY_README}" ]]; then
  H=$(grep -m1 '^# ' "${DAY_README}" | sed 's/^# //')
  [[ -n "${H}" ]] && TITLE="${H}"
  SUB=$(grep -m1 '^- Enunciado:' "${DAY_README}" | sed 's/^- Enunciado:[[:space:]]*//')
fi

NEW_MSG="feat: ${TITLE}"
[[ -n "${SUB}" ]] && NEW_MSG="${NEW_MSG} — ${SUB}"

if [[ -s "${MSG_FILE}" ]]; then
  printf "%s\n\n%s\n" "${NEW_MSG}" "$(cat "${MSG_FILE}")" > "${MSG_FILE}"
else
  printf "%s\n" "${NEW_MSG}" > "${MSG_FILE}"
fi
EOF
  chmod +x .git/hooks/prepare-commit-msg
}

main() {
  # Preenche READMEs de cada dia
  for e in "${DAYS_DEF[@]}"; do
    IFS='|' read -r num title stmt <<<"$e"
    write_day_readme "$num" "$title" "$stmt"
  done

  # Gera README raiz com índice
  generate_root_readme

  # Instala hook de commit
  install_prepare_commit_hook

  echo "READMEs e hook instalados. Agora:"
  echo "  git add ."
  echo "  git commit (a mensagem será montada automaticamente ao commitar mudanças por dia)"
  echo "  git push"
}

main "$@"
