# Powerlevel10k 即时提示。应尽可能靠近 ~/.zshrc 顶部。
# 任何需要控制台输入（如密码、[y/n]确认等）的初始化代码必须放在此块上方；其他所有代码可以放在下方。
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh 的安装路径
export ZSH="$HOME/.oh-my-zsh"

# 设置加载的主题名称
ZSH_THEME="powerlevel10k/powerlevel10k"

# 要加载的插件列表
plugins=(git zsh-autosuggestions zsh-syntax-highlighting z extract sudo asdf)

# 加载 Oh My Zsh 核心功能
source $ZSH/oh-my-zsh.sh

# 用户配置

# 设置语言环境
export LANG=en_US.UTF-8

# 个人别名
alias this="/mnt/c/Windows/explorer.exe ." # 在 WSL 中打开当前目录的 Windows 资源管理器
alias ports='netstat -tulanp'            # 查看所有监听端口和进程
alias h='history'                        # 历史命令
alias vim='nvim'                         # 将 vim 别名为 neovim
alias vi='nvim'                          # 将 vi 别名为 neovim
# 查ip
alias getipcn="curl myip.ipip.net"
alias getip="curl -L ipip.info/json"

# Powerlevel10k 配置。如果文件存在，则加载它。
# 运行 `p10k configure` 或编辑 ~/.p10k.zsh 来自定义提示符。
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 设置 Vim 模式下的光标形状
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q' # Vim 命令模式下显示块状光标
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q' # 插入模式或默认模式下显示竖线光标
  fi
}
zle -N zle-keymap-select # 注册函数以在按键映射改变时调用
set -o vi                # 启用 Zsh 的 Vim 模式

# 设置 PATH 环境变量
export PATH="/home/Pepster/.local/bin:$PATH"

# 初始化 asdf 版本管理器
. $HOME/.asdf/asdf.sh

# 禁用 zsh argcomplete (Python 自动补全功能)
unfunction _python_argcomplete_global_fallback_completer 2>/dev/null
unfunction _python_argcomplete_global 2>/dev/null

# 定义代理地址变量
httpproxy=http://127.0.0.1:10808
socksproxy=socks5://127.0.0.1:10808

# 设置使用代理
alias setproxy="export http_proxy=$httpproxy; export https_proxy=$httpproxy; export all_proxy=$socksproxy; echo 'Set proxy successfully'"

# 设置取消使用代理
alias unsetproxy="unset http_proxy; unset https_proxy; unset all_proxy; echo 'Unset proxy successfully'"

# tmux添加为默认启动项，并保存上次会话回溯
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # 尝试附加到现有会话，如果没有则创建新会话
    tmux new-session -A -s main
fi


