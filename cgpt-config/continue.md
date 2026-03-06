```yaml
name: Local Assistant
version: 1.0.0
schema: v1
models:
  - name: "GPT-4o"
    model: gpt-4o
    provider: openai
    apiBase: http://localhost:1222/v1
    apiKey: api
  - name: "GPT-4o-mini"
    model: gpt-4o-mini
    provider: openai
    apiBase: http://localhost:1222/v1
    apiKey: api
context:
  - provider: code
  - provider: docs
  - provider: diff
  - provider: terminal
  - provider: problems
  - provider: folder
  - provider: codebase
```
