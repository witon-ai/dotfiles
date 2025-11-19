# README.md

这个文档提供了该 dotfiles 仓库的使用指南和配置说明。

## 项目概述

这是一个使用 Chezmoi 管理的个人 dotfiles 仓库，支持跨平台（macOS 和 Linux）配置管理。Chezmoi 是一个 dotfiles 管理工具，可以安全地管理配置文件，支持模板化和加密。

## 核心架构

### Chezmoi 结构
- `home/` - 包含所有配置文件的源文件
- `.chezmoiroot` - 指定 Chezmoi 的根目录为 "home"
- `home/.chezmoi.toml.tmpl` - Chezmoi 配置模板，定义加密设置
- `home/.chezmoidata/packages.yaml` - 包管理配置数据

### 配置文件类型
- `dot_*` - 会被重命名为 `.*` 的普通配置文件
- `*.tmpl` - Chezmoi 模板文件，支持条件渲染和变量
- `*.age` - 使用 Age 加密的敏感文件
- `.chezmoiexternal.toml` - 外部资源配置（如 Oh My Zsh 主题和插件）

### 平台特定脚本
- `home/.chezmoiscripts/linux/` - Linux 特定安装脚本
- `home/.chezmoiscripts/darwin/` - macOS 特定安装脚本

## 常用命令

### 初始化和安装
```bash
# 安装 Chezmoi 和生成密钥（仅首次）
./startup.sh

# 应用配置到当前系统
chezmoi init

# 应用所有配置文件
chezmoi apply

# 更新外部资源
chezmoi archive --include=*,!/private --output=dotfiles.tar.gz
```

### 日常管理
```bash
# 编辑某个配置文件
chezmoi edit ~/.zshrc

# 查看配置文件状态
chezmoi status

# 添加新配置文件到管理
chezmoi add ~/.config/some-app/config

# 从外部资源更新
chezmoi apply --external
```

### 加密文件管理
```bash
# 编辑加密文件
chezmoi edit --decrypt ~/.ssh/private_key

# 添加新的加密文件
chezmoi add --encrypt ~/.ssh/private_key
```

## 配置管理

### 包管理
- `home/.chezmoidata/packages.yaml` 定义了不同平台的软件包
- 支持 Homebrew（macOS）、APT（Linux）、NPM 全局包、pipx
- 安装脚本会在系统配置变更时自动执行

### 环境变量和路径
- Chezmoi 配置目录：`$HOME/Documents/.config/chezmoi/`
- Age 密钥文件：`$CHEZMOI_AGE_HOME/key.txt`
- 外部资源自动下载到 `$HOME/.oh-my-zsh/`

### 安全性
- 敏感文件（如 SSH 私钥、个人配置文件）使用 Age 加密
- 公钥存储在 `$CHEZMOI_AGE_HOME/key.pub`
- 模板文件使用动态路径，避免硬编码

## 开发工作流

### 修改配置
1. 使用 `chezmoi edit <file>` 编辑现有配置
2. 或者直接编辑 `home/` 目录下的源文件
3. 使用 `chezmoi diff` 查看变更
4. 使用 `chezmoi apply` 应用变更
5. 提交到 git 仓库

### 添加新配置
1. 将配置文件放置到正确位置
2. 使用 `chezmoi add <file>` 添加到管理
3. 对于敏感文件，使用 `chezmoi add --encrypt <file>`
4. 提交到 git 仓库

### 平台特定配置
- 使用 `{{ if eq .chezmoi.os "linux" }}` 或 `{{ if eq .chezmoi.os "darwin" }}` 条件
- 模板变量：`.chezmoi.os`、`.chezmoi.homeDir`、`.chezmoi.username`