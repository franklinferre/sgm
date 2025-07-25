# 🚀 SGM - Sistema de Gestão de Máquina v3.0

Sistema completo para instalação, configuração e manutenção de servidores **Debian/Ubuntu**.

![Badge](https://img.shields.io/badge/Version-3.0-blue)
![Badge](https://img.shields.io/badge/OS-Debian%2FUbuntu-orange)
![Badge](https://img.shields.io/badge/Shell-Bash-green)

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Como Usar](#-como-usar)
- [Menu Principal](#-menu-principal)
- [Recursos Avançados](#-recursos-avançados)
- [Configurações de Rede](#-configurações-de-rede)
- [Segurança](#-segurança)
- [Logs e Monitoramento](#-logs-e-monitoramento)
- [Contribuição](#-contribuição)

## 🎯 Sobre o Projeto

O **SGM** é um script Bash completo que automatiza a instalação, configuração e manutenção de servidores Linux. Desenvolvido especificamente para **Debian/Ubuntu**, oferece uma interface interativa colorida com 18 funcionalidades essenciais.

### ✨ Principais Características

- 🎨 **Interface colorida** e intuitiva
- 🔧 **18 funcionalidades** organizadas em categorias
- 🌐 **Gerenciamento avançado de rede** (sub-IPs + iptables)
- 🐳 **Docker** completo (instalação + limpeza)
- 🔒 **Segurança** robusta (UFW + Fail2Ban + SSH)
- 📡 **FRR/BGP** integrado
- 🧹 **Manutenção** automatizada
- 📊 **Monitoramento** de sistema

## 🛠️ Funcionalidades

### 📦 Sistema
- ✅ Update/Upgrade completo
- ✅ Instalação de pacotes essenciais
- ✅ Configuração de timezone
- ✅ Limpeza completa do sistema

### 🐳 Docker
- ✅ Instalação do Docker + Docker Compose
- ✅ Configuração de usuários
- ✅ Limpeza completa (prune automático)

### 🌐 Rede
- ✅ **Adicionar sub-IPs** em interfaces
- ✅ **Listar sub-IPs** configurados
- ✅ **Remover sub-IPs** específicos
- ✅ **Regras iptables SNAT** automáticas
- ✅ Configuração de DNS
- ✅ **Netplan** automático

### 🔒 Segurança
- ✅ Firewall UFW configurado
- ✅ Fail2Ban anti-bruteforce
- ✅ SSH Hardening completo

### 📡 FRR/BGP
- ✅ Instalação do FRR
- ✅ Configuração BGP completa
- ✅ Anúncio de subnets

### 🧹 Manutenção
- ✅ Limpeza de cache APT
- ✅ Remoção de logs antigos
- ✅ Limpeza de arquivos temporários
- ✅ Informações detalhadas do sistema

## 📋 Pré-requisitos

- **OS**: Debian 9+ ou Ubuntu 18.04+
- **Usuário**: root ou sudo
- **Conexão**: Internet ativa
- **Espaço**: ~100MB livre

## 🚀 Instalação

### 1. Download do Script

```bash
# Clone do repositório
git clone https://github.com/seu-usuario/sgm.git
cd sgm

# Ou download direto
wget https://raw.githubusercontent.com/seu-usuario/sgm/main/sgm.sh
chmod +x sgm.sh
```

### 2. Executar o Script

```bash
sudo ./sgm.sh
```

## 🎮 Como Usar

### Execução Simples

```bash
sudo ./sgm.sh
```

### Menu Interativo

O script apresenta um menu colorido com 18 opções organizadas:

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                    Sistema de Gestão de Máquina v3.0                    ║
╚══════════════════════════════════════════════════════════════════════════════╝

Selecione uma opção:

 1)  🔄 Atualizar sistema (update/upgrade)
 2)  📦 Instalar pacotes essenciais
 ...
18)  🚀 Configuração completa (recomendado)
```

## 📋 Menu Principal

| Opção | Funcionalidade | Descrição |
|-------|---------------|-----------|
| **1** | 🔄 Sistema | Update/upgrade completo |
| **2** | 📦 Pacotes | Instalação de essenciais |
| **3** | 🕒 Timezone | Configuração de fuso |
| **4** | 🐳 Docker | Instalação completa |
| **5** | 🧹 Docker | Limpeza e manutenção |
| **6** | 🌐 Sub-IP | Adicionar IP + iptables |
| **7** | 📋 Sub-IP | Listar configurados |
| **8** | ❌ Sub-IP | Remover específicos |
| **9** | 🔍 iptables | Ver regras SNAT |
| **10** | 🔍 DNS | Configurar servidores |
| **11** | 🔒 UFW | Configurar firewall |
| **12** | 🛡️ Fail2Ban | Anti-bruteforce |
| **13** | 🔑 SSH | Hardening completo |
| **14** | 📡 FRR | Instalação BGP |
| **15** | ⚙️ BGP | Configuração completa |
| **16** | 🧹 Sistema | Limpeza completa |
| **17** | 📊 Info | Informações detalhadas |
| **18** | 🚀 Setup | Configuração automática |

## 🌐 Recursos Avançados

### Sub-IPs com SNAT

Configuração automática de IPs adicionais com regras iptables:

```bash
# Exemplo automático:
ip addr add 172.64.0.4/32 dev eth0
iptables -t nat -A POSTROUTING -o eth0 ! -d 10.128.0.0/10 -j SNAT --to-source 172.64.0.4
```

### Netplan Automático

- ✅ **Instalação automática** do netplan.io
- ✅ **Preserva DHCP** + adiciona sub-IPs
- ✅ **Migração** de /etc/network/interfaces
- ✅ **Configuração persistente**

### Gerenciamento Inteligente

```bash
# Múltiplos sub-IPs na mesma interface
eth0: 
  - 10.128.1.202/24    (DHCP principal)
  - 172.64.0.4/32      (Sub-IP 1)
  - 186.208.0.27/32    (Sub-IP 2)
```

## 🔒 Configurações de Rede

### Sub-IPs Automáticos

1. **Seleção de interface** interativa
2. **Validação de IP** automática
3. **Configuração iptables** SNAT
4. **Persistência** via netplan
5. **Backup** de configurações

### DNS Configurável

- Google DNS (8.8.8.8, 8.8.4.4)
- Cloudflare DNS (1.1.1.1, 1.0.0.1)
- OpenDNS (208.67.222.222, 208.67.220.220)
- DNS personalizado

## 🛡️ Segurança

### Firewall UFW

```bash
# Configuração padrão:
- SSH (22): ✅ Permitido
- HTTP (80): ✅ Permitido  
- HTTPS (443): ✅ Permitido
- Outras portas: Interativo
```

### Fail2Ban

```bash
# Configuração automática:
- SSH: 3 tentativas / 1 hora banimento
- Apache: Proteção anti-bots
- Logs: /var/log/auth.log
```

### SSH Hardening

```bash
# Melhorias aplicadas:
- PermitRootLogin: no
- MaxAuthTries: 3
- ClientAliveInterval: 300
- Protocol: 2
```

## 📊 Logs e Monitoramento

### Sistema de Logs

```bash
# Log principal
/var/log/sgm.log

# Formato
2024-07-25 13:21:45 - INFO: Sistema atualizado com sucesso
2024-07-25 13:22:10 - SUCCESS: Docker instalado
```

### Informações do Sistema

- ✅ **OS e Kernel** detalhados
- ✅ **Uptime e Memória** em tempo real
- ✅ **Interfaces de rede** configuradas
- ✅ **Serviços ativos** monitorados
- ✅ **Containers Docker** listados

## 🎯 Configuração Completa

### Opção 18: Setup Automático

Executa sequencialmente:

1. ✅ Atualização do sistema
2. ✅ Pacotes essenciais
3. ✅ Instalação Docker
4. ✅ Configuração UFW
5. ✅ Instalação Fail2Ban
6. ✅ SSH Hardening
7. ✅ Instalação FRR

**Tempo estimado**: 5-10 minutos

## 🔧 Pacotes Instalados

### Sistema Base
```
curl, wget, vim, nano, htop, tree, unzip, git
net-tools, dnsutils, tcpdump, iptables-persistent
```

### Infraestrutura
```
docker-ce, docker-compose-plugin, netplan.io
ufw, fail2ban, software-properties-common
```

### Rede
```
frr, frr-pythontools
```

## 📖 Exemplos de Uso

### Adicionar Sub-IP

```bash
sudo ./sgm.sh
# Escolher opção 6
# Selecionar interface: eth0
# Digitar IP: 172.64.0.4/32
# Resultado: IP + regra iptables SNAT configurados
```

### Configuração BGP

```bash
sudo ./sgm.sh
# Escolher opção 14 (instalar FRR)
# Escolher opção 15 (configurar BGP)
# Digitar subnet: 172.64.0.0/24
# Resultado: BGP funcionando com anúncio
```

### Limpeza Completa

```bash
sudo ./sgm.sh
# Escolher opção 16
# Resultado: Sistema limpo e otimizado
```

## 🤝 Contribuição

### Como Contribuir

1. **Fork** o projeto
2. **Clone** sua fork
3. **Crie** uma branch para sua feature
4. **Commit** suas mudanças
5. **Push** para a branch
6. **Abra** um Pull Request

### Estrutura do Código

```bash
sgm.sh
├── Variáveis globais
├── Funções utilitárias
├── Módulo Sistema
├── Módulo Docker
├── Módulo Rede
├── Módulo Segurança
├── Módulo FRR
├── Módulo Manutenção
├── Menu Principal
└── Execução
```

### Padrões de Código

- ✅ **Comentários** em português
- ✅ **Funções modulares** bem definidas
- ✅ **Validação** de entrada sempre
- ✅ **Logs** de todas as ações
- ✅ **Tratamento** de erros robusto

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Suporte

- 🐛 **Issues**: GitHub Issues
- 📧 **Email**: seu-email@exemplo.com
- 💬 **Discussões**: GitHub Discussions

---

## 🙏 Agradecimentos

- Comunidade **Debian/Ubuntu**
- Desenvolvedores **FRR**
- Projeto **Docker**
- Equipe **Netplan**

---

<div align="center">

**⭐ Se este projeto foi útil, deixe uma estrela no GitHub! ⭐**

[🔗 Reportar Bug](https://github.com/seu-usuario/sgm/issues) • [💡 Sugerir Feature](https://github.com/seu-usuario/sgm/issues) • [📖 Documentação](https://github.com/seu-usuario/sgm/wiki)

</div> 