# Plannex 📋

Um aplicativo Flutter completo e moderna para gerenciamento de projetos, tarefas, decisões e diário pessoal. Organize suas ideias, acompanhe o progresso e mantenha o registro de suas jornadas profissionais e pessoais.

## 🎯 Sobre o Projeto

**Plannex** é um aplicativo de produtividade construído com Flutter que permite aos usuários:
- 🎨 Criar e gerenciar múltiplos projetos
- ✅ Organizar tarefas dentro de cada projeto
- 💡 Registrar e controlar decisões importantes
- 📝 Manter um diário pessoal
- 🌙 Alternar entre temas claro e escuro
- 💾 Persistência de dados local (sem dependência de Internet)

## ✨ Funcionalidades Principais

### Gerenciamento de Projetos
- Criar novos projetos com nome, descrição e cor identificadora
- Editar informações dos projetos existentes
- Visualizar detalhes completos de cada projeto
- Organizar projetos de forma intuitiva

### Gerenciamento de Tarefas
- Adicionar tarefas associadas a cada projeto
- Marcar tarefas como concluídas/pendentes
- Editar e deletar tarefas
- Acompanhar progresso do projeto

### Registro de Decisões
- Documentar decisões importantes
- Manter histórico de decisões tomadas
- Facilita rastreabilidade de escolhas

### Diário Pessoal
- Escrever e armazenar entradas de diário
- Reflexões diárias ou periódicas
- Acompanhamento do crescimento pessoal

### Customização
- **Tema Dinâmico**: Suporte completo para modo claro e escuro
- **Interface Moderna**: Design clean e intuitivo
- **Responsivo**: Funciona perfeitamente em diferentes tamanhos de tela

## 🛠️ Tecnologias Utilizadas

- **Flutter 3.10+** - Framework para desenvolvimento multiplataforma
- **Dart** - Linguagem de programação
- **Provider** - Gerenciamento de estado
- **SharedPreferences** - Armazenamento local de dados
- **Material Design 3** - Design system
- **Intl** - Internacionalização e formatação de datas

### Dependências Principais

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2
  provider: ^6.0.0
  intl: ^0.19.0
```

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- **Flutter SDK** (versão 3.10.0 ou superior)
  - [Guia de instalação do Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (incluído no Flutter)
- **Android Studio** (para desenvolveu para Android) ou **Xcode** (para iOS)
- **Git** (opcional, para clonar o repositório)

Verifique a instalação executando:
```bash
flutter --version
dart --version
```

## 🚀 Como Instalar e Executar

### 1. Clonar ou baixar o projeto

```bash
# Se estiver usando Git
git clone <seu-repositorio>
cd gestor_de_projetos

# Ou simplesmente abra a pasta do projeto
```

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Executar o aplicativo

```bash
# Para executar em um emulador ou dispositivo conectado
flutter run

# Para compilar em release
flutter build apk       # Android APK
flutter build ios       # iOS IPA
flutter build web       # Web
```

### 4. Desenvolvimento

```bash
# Hot reload durante o desenvolvimento
flutter run

# Hot restart (reinicia a aplicação mantendo estado)
# Pressione 'R' no terminal durante a execução
```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── theme/
│   └── app_theme.dart          # Configuração de tema (claro/escuro)
├── screens/                     # Telas da aplicação
│   ├── home_screen.dart         # Tela inicial
│   ├── project_form_screen.dart # Criar/editar projeto
│   ├── project_detail_screen.dart # Detalhes do projeto
│   └── task_form_screen.dart    # Criar/editar tarefa
├── models/
│   └── models.dart              # Modelos de dados (Project, Task, etc)
├── providers/                   # Gerenciamento de estado
│   ├── providers.dart           # Providers de negócio
│   ├── theme_provider.dart      # Provider de tema
│   └── ...
├── widgets/                     # Componentes reutilizáveis
│   └── widgets.dart
├── core/
│   ├── constants/               # Cores, dimensões, estilos
│   │   ├── app_colors.dart
│   │   ├── app_dimen.dart
│   │   └── app_text_styles.dart
│   └── storage/                 # Camada de persistência
│       └── local_storage.dart
└── assets/                      # Imagens e recursos estáticos
```

## 🎨 Arquitetura

O projeto segue uma arquitetura limpa com separação de responsabilidades:

- **Models**: Structs de dados imutáveis
- **Providers**: Gerenciamento de estado da aplicação
- **Screens**: Telas principais da UI
- **Widgets**: Componentes reutilizáveis
- **Core**: Utilitários, constantes e serviços
- **Storage**: Persistência de dados local

## 🔧 Configuração de Desenvolvimento

### Gerar ícone do aplicativo

O projeto usa `flutter_launcher_icons` para gerenciar ícones:

```bash
flutter pub run flutter_launcher_icons
```

### Análise estática de código

```bash
flutter analyze
```

### Executar testes (quando implementados)

```bash
flutter test
```

## 📝 Como Usar

1. **Criar um Projeto**
   - Clique no botão de adição na tela inicial
   - Preencha nome, descrição e escolha uma cor
   - Salve o projeto

2. **Adicionar Tarefas**
   - Abra um projeto
   - Clique em "Adicionar Tarefa"
   - Preencha os detalhes da tarefa
   - Salve

3. **Registrar Decisões e Diário**
   - Use o menu para acessar as respectivas seções
   - Escreva e salve seus registros
   - Todos os dados são salvos automaticamente

4. **Personalizar Aparência**
   - Acesse as configurações
   - Ative/desative o modo escuro
   - As preferências são lembradas

## 💾 Armazenamento de Dados

O aplicativo usa **SharedPreferences** para persistência local:
- Todos os dados são salvos no dispositivo
- Sem necessidade de conexão de Internet
- Segurança básica com padrão encryption (depende do dispositivo)

## 🤝 Contribuindo

Sugestões de melhorias sempre bem-vindas! Se você quiser contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### Áreas para Contribuição
- Melhorias na UI/UX
- Novos recursos e funcionalidades
- Otimizações de performance
- Tradução para outros idiomas
- Testes automatizados

## 🐛 Reportar Problemas

Se encontrou um bug, por favor abra uma **Issue** descrevendo:
- O que você estava tentando fazer
- O que aconteceu
- Passos para reproduzir o problema
- Device/versão do Flutter utilizados

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

Desenvolvido como um projeto pessoal de produtividade.

---

## 📚 Recursos Úteis

- [Documentação do Flutter](https://flutter.dev/docs)
- [Documentação do Dart](https://dart.dev/guides)
- [Guia de Provider](https://pub.dev/packages/provider)
- [Material Design 3](https://m3.material.io/)

## 🎓 Aprender com esse Projeto

Este projeto demonstra:
- ✅ Padrão Provider para gerenciamento de estado
- ✅ Navegação com rotas nomeadas
- ✅ Armazenamento local com SharedPreferences
- ✅ Tema dinâmico (claro/escuro)
- ✅ Separação de responsabilidades
- ✅ Componentes reutilizáveis
- ✅ Tratamento de dados

---

**Desenvolvido com ❤️ usando Flutter**
