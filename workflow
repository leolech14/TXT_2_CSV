name: Converter TXT ➜ CSV

on:
  push:
    # só dispara quando um .txt ou o script mudar
    paths:
      - '**/*.txt'
      - 'src/itau_batch_txt2csv.py'

jobs:
  extract:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - uses: actions/setup-python@v5
      with:
        python-version: '3.11'

    - name: Executar parser (todos os .txt em faturas/)
      run: |
        mkdir -p output
        python src/itau_batch_txt2csv.py faturas/*.txt > output/run.log 2>&1
        mv faturas/*_done.csv output/ || true   # move CSVs gerados

    - name: Commit artefatos de volta
      run: |
        git config user.name  "itau-bot"
        git config user.email "itau-bot@users.noreply.github.com"
        git add output/*.csv output/run.log
        git commit -m "bot: atualiza CSV $(date +'%F %T')" || echo "Nada novo"
        git push
